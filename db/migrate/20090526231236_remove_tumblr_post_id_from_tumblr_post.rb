class RemoveTumblrPostIdFromTumblrPost < ActiveRecord::Migration
  def self.up
    remove_column :tumblr_posts, :tumblr_post_id
  end

  def self.down
    add_column :tumblr_posts, :tumblr_post_id, :string
  end
end
