class AddTumblrIdToTumblrPost < ActiveRecord::Migration
  def self.up
    add_column :tumblr_posts, :tumblr_id, :integer
  end

  def self.down
    remove_column :tumblr_posts, :tumblr_id
  end
end
