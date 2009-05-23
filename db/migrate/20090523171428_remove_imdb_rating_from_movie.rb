class RemoveImdbRatingFromMovie < ActiveRecord::Migration
  def self.up
    remove_column :movies, :imdb_rating
  end

  def self.down
    add_column :movies, :imdb_rating, :integer
  end
end
