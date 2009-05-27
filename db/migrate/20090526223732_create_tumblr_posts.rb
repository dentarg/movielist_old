class CreateTumblrPosts < ActiveRecord::Migration
  def self.up
    create_table :tumblr_posts do |t|
      t.integer :user_id
      t.string :tumblr_post_id
      t.integer :favorite_id
      t.integer :towatch_id
      t.integer :seen_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tumblr_posts
  end
end
