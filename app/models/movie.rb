class Movie < ActiveRecord::Base
  IMDB_URL_RE_OK = /^(http):\/\/(.*)\.imdb.com\/title\/(tt\d+)/
  validates_format_of :imdb_url, :with => IMDB_URL_RE_OK, :on => :create,
    :message => "Not a correct IMDB URL"#, :allow_nil => true, :allow_blank => true
  validates_uniqueness_of :imdb_id, :on => :create, 
    :message => "Movie already exists"#, :allow_nil => true, :allow_blank => true

  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
  has_many :favorites, :dependent => :destroy
  has_many :seen, :dependent => :destroy
  has_many :towatch, :dependent => :destroy

  def self.imdb_url_regexp
    IMDB_URL_RE_OK
  end
  
  # Makes sense, dosen't it? :-)
  # Hack for seen, towatch and favorite
  def movie
    self
  end
  
  def to_s
    self.title
  end

  def seen?(user)
    user.seen_movies.include?(self)
  end
  
  def favorite?(user)
    user.favorite_movies.include?(self)
  end
  
  def towatch?(user)
    user.towatch_movies.include?(self)
  end

end
