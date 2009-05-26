class RenameUserIdToCreatedByInMovieNights < ActiveRecord::Migration
  def self.up
    rename_column :movie_nights, :user_id, :created_by
  end

  def self.down
    rename_column :movie_nights, :created_by, :user_id
  end
end
