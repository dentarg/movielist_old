class RemoveCountFromSeenMovie < ActiveRecord::Migration
  def self.up
    remove_column :seen_movies, :count
  end

  def self.down
    add_column :seen_movies, :count, :integer
  end
end
