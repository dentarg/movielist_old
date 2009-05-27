class TumblrPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :seen
  belongs_to :towatch
  belongs_to :favorite
  
  before_destroy :remove_from_tumblr
  
  protected
  
  def remove_from_tumblr
    if self.user.has_tumblr?
      user = Tumblr::User.new(self.user.tumblr_username, self.user.tumblr_password, false)
      post = Tumblr::Post.destroy(user, :post_id => self.tumblr_id)
    end
  end
end
