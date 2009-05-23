class RenameImdbGradeToImdbRatingInMovie < ActiveRecord::Migration
  def self.up
    rename_column :movies, :imdb_grade, :imdb_rating
  end

  def self.down
    rename_column :movies, :imdb_rating, :imdb_grade
  end
end
