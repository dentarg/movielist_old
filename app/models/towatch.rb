class Towatch < ActiveRecord::Base
  set_table_name 'towatch'
  
  belongs_to :movie
  belongs_to :user
  
  delegate  :title,       :to => :movie
  delegate  :title_sv,    :to => :movie
  delegate  :year,        :to => :movie
  delegate  :imdb_id,     :to => :movie
  delegate  :imdb_url,    :to => :movie
  delegate  :imdb_rating, :to => :movie
  delegate  :dn_grade,    :to => :movie
  delegate  :dn_url,      :to => :movie
  
  delegate  :seen?,     :to => :movie
  delegate  :favorite?, :to => :movie
  delegate  :towatch?,  :to => :movie

  has_one :tumblr_post, :dependent => :destroy
  after_create :share_on_tumblr
  
  protected
  
  def share_on_tumblr
    if self.user.has_tumblr?
      user = Tumblr::User.new(self.user.tumblr_username, self.user.tumblr_password, false)
      post = Tumblr::Post.create(user, 
        :type => 'regular', 
        :body => "<a href='#{APP_CONFIG[:site_url]}'>movielist</a>: Gonna watch <a href='#{self.movie.imdb_url}'>#{self.movie.title}</a> someday.")
      @tumblr_post = TumblrPost.new
      @tumblr_post.tumblr_id = post.to_i
      @tumblr_post.user = self.user
      @tumblr_post.towatch = self
      @tumblr_post.save!
    end
  end
end
