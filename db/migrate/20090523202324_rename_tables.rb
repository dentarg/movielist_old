class RenameTables < ActiveRecord::Migration
  def self.up
    rename_table :seen_movies, :seen
    rename_table :to_watch_movies, :towatch
  end

  def self.down
    rename_table :seen, :seen_movies
    rename_table :towatch, :to_watch_movies
  end
end
