class RenameColumnsInMovieNight < ActiveRecord::Migration
  def self.up
    rename_column :movie_nights, :users, :user_ids
    rename_column :movie_nights, :movies_towatch, :towatch_movie_ids
    rename_column :movie_nights, :movies_seen, :seen_movie_ids
  end

  def self.down
    rename_column :movie_nights, :user_ids, :users
    rename_column :movie_nights, :towatch_movie_ids, :movies_towatch
    rename_column :movie_nights, :seen_movie_ids, :movies_seen
  end
end
