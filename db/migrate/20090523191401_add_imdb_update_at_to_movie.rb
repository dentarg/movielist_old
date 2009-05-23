class AddImdbUpdateAtToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :imdb_update_at, :datetime
  end

  def self.down
    remove_column :movies, :imdb_update_at
  end
end
