class RemoveColumnsFromMovieNights < ActiveRecord::Migration
  def self.up
    remove_column :movie_nights, :towatch_movie_ids
    remove_column :movie_nights, :seen_movie_ids
    rename_column :movie_nights, :user_ids, :user_id
  end

  def self.down
    add_column :movie_nights, :towatch_movie_ids
    add_column :movie_nights, :seen_movie_ids
    rename_column :movie_nights, :user_id, :user_ids
  end
end
