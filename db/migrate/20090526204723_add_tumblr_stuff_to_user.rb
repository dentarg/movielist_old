class AddTumblrStuffToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :tumblr_username, :string
    add_column :users, :tumblr_password, :string
  end

  def self.down
    remove_column :users, :tumblr_password
    remove_column :users, :tumblr_username
  end
end
