class RemoveImdbUrlFromMovie < ActiveRecord::Migration
  def self.up
    remove_column :movies, :imdb_url
  end

  def self.down
    add_column :movies, :imdb_url, :string
  end
end
