class CreateToWatchMovies < ActiveRecord::Migration
  def self.up
    create_table :to_watch_movies do |t|
      t.integer :movie_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :to_watch_movies
  end
end
