class AddImdbRatingToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :imdb_rating, :string
  end

  def self.down
    remove_column :movies, :imdb_rating
  end
end
