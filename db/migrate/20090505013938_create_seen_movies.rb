class CreateSeenMovies < ActiveRecord::Migration
  def self.up
    create_table :seen_movies do |t|
      t.integer :movie_id
      t.integer :user_id
      t.integer :count

      t.timestamps
    end
  end

  def self.down
    drop_table :seen_movies
  end
end
