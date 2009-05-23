class RenameFavoriteMoviesToFavorites < ActiveRecord::Migration
  def self.up
    rename_table :favorite_movies, :favorites
  end

  def self.down
    rename_table :favorites, :favorite_movies
  end
end
