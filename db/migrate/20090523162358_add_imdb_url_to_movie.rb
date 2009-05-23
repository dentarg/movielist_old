class AddImdbUrlToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :imdb_url, :string
  end

  def self.down
    remove_column :movies, :imdb_url
  end
end
