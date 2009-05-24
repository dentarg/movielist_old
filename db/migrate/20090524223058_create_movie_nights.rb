class CreateMovieNights < ActiveRecord::Migration
  def self.up
    create_table :movie_nights do |t|
      t.string :users
      t.text :movies_towatch
      t.text :movies_seen

      t.timestamps
    end
  end

  def self.down
    drop_table :movie_nights
  end
end
