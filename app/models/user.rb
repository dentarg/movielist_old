require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include Authorization::AasmRoles

  # Validations
  validates_presence_of :login, :if => :not_using_openid?
  validates_length_of :login, :within => 3..40, :if => :not_using_openid?
  validates_uniqueness_of :login, :case_sensitive => false, :if => :not_using_openid?
  validates_format_of :login, :with => RE_LOGIN_OK, :message => MSG_LOGIN_BAD, :if => :not_using_openid?
  validates_format_of :name, :with => RE_NAME_OK, :message => MSG_NAME_BAD, :allow_nil => true
  validates_length_of :name, :maximum => 100
  validates_presence_of :email, :if => :not_using_openid?
  validates_length_of :email, :within => 6..100, :if => :not_using_openid?
  validates_uniqueness_of :email, :case_sensitive => false, :if => :not_using_openid?
  validates_format_of :email, :with => RE_EMAIL_OK, :message => MSG_EMAIL_BAD, :if => :not_using_openid?
  validates_uniqueness_of :identity_url, :unless => :not_using_openid?
  validate :normalize_identity_url
  
  # Relationships
  has_and_belongs_to_many :roles

  has_and_belongs_to_many :movie_nights
  
  has_many :towatch
  has_many :seen
  has_many :favorites
  
  has_many :seen_movies,      :through => :seen,      :source => :movie
  has_many :towatch_movies,   :through => :towatch,   :source => :movie
  has_many :favorite_movies,  :through => :favorites, :source => :movie

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :identity_url,
    :first_name, :last_name, :tumblr_username, :tumblr_password

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_in_state :first, :active, :conditions => { :login => login } # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end
  
  # Check if a user has a role.
  def has_role?(role)
    list ||= self.roles.map(&:name)
    list.include?(role.to_s) || list.include?('admin')
  end
  
  # Not using open id
  def not_using_openid?
    identity_url.blank?
  end
  
  # Overwrite password_required for open id
  def password_required?
    new_record? ? not_using_openid? && (crypted_password.blank? || !password.blank?) : !password.blank?
  end


  def has_tumblr?
    self.tumblr_username && self.tumblr_password ? true : false
  end

  def seen_imdb_rating
    movies = self.seen_movies
    unless movies.empty?
      "%0.1f" % (movies.collect { |m| m.imdb_rating.to_f }.inject() { |sum,element| sum+element } / movies.length)
    end
  end
  
  def towatch_imdb_rating
    movies = self.towatch_movies
    unless movies.empty?
      "%0.1f" % (movies.collect { |m| m.imdb_rating.to_f }.inject() { |sum,element| sum+element } / movies.length)
    end
  end
  
  def favorite_imdb_rating
    movies = self.favorite_movies
    unless movies.empty?
      "%0.1f" % (movies.collect { |m| m.imdb_rating.to_f }.inject() { |sum,element| sum+element } / movies.length)
    end
  end
  
  def to_s
    self.login
  end
  
  def real_name
    "#{self.first_name} #{self.last_name}"
  end

  # the magic star
  # --------------
  # >> array = [ :a, :b ]
  # => [:a, :b]
  # 
  # >> [ :c, array ]
  # => [:c, [:a, :b]]
  # 
  # >> [ :c, *array ]
  # => [:c, :a, :b]
  
  # search("word1 word2") gives a condition like
  # ["(LOWER(login) LIKE ? OR LOWER(name) LIKE ?) AND (LOWER(login) LIKE ? OR LOWER(name) LIKE ?)", 
  #   "%word1%", "%word1%", "%word2%", "%word2%"]
  
  # Written by Johan Eckerström <johan@duh.se>
  def self.search(keyword)
    if not keyword.to_s.strip.empty?
      keys = [:login, :name]
      sql_keys = keys.collect {|k| "LOWER(#{k}) LIKE ?"}.join(' OR ')
      keyword.gsub!('*', '%')
      tokens = keyword.split.collect {|c| "%#{c.downcase}%"}
      condition = [(["(#{sql_keys})"] * tokens.size).join(" AND "),
        *tokens.collect {|t| [t] * keys.length }.flatten]
      self.find(:all, :conditions => condition)
    else
      []
    end
  end
  
  protected
    
  def make_activation_code
    self.deleted_at = nil
    self.activation_code = self.class.make_token
  end
  
  def normalize_identity_url
    self.identity_url = OpenIdAuthentication.normalize_url(identity_url) unless not_using_openid?
  rescue URI::InvalidURIError
    errors.add_to_base("Invalid OpenID URL")
  end
end
