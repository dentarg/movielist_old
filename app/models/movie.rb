class Movie < ActiveRecord::Base
  
  IMDB_URL_RE_OK = /^(http):\/\/(.*)\.imdb.com\/title\/(tt\d+)/
  
  validates_format_of :imdb_url, :with => IMDB_URL_RE_OK, :on => :create,
    :message => "Not a correct IMDB URL"#, :allow_nil => true, :allow_blank => true

  validates_uniqueness_of :imdb_id, :on => :create, 
    :message => "Movie already exists"#, :allow_nil => true, :allow_blank => true

  def self.imdb_url_regexp
    IMDB_URL_RE_OK
  end

  def seen?(user)
    user.movies_seen.include?(self)
  end
  
  def favorite?(user)
    user.movies_favorite.include?(self)
  end
  
  def to_watch?(user)
    user.movies_to_watch.include?(self)
  end

end
