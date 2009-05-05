class CreateFavoriteMovies < ActiveRecord::Migration
  def self.up
    create_table :favorite_movies do |t|
      t.integer :movie_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :favorite_movies
  end
end
