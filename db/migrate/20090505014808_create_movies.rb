class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :name
      t.string :year
      t.string :imdb_id
      t.string :imdb_url
      t.integer :imdb_grade
      t.string :dn_url
      t.integer :dn_grade

      t.timestamps
    end
  end

  def self.down
    drop_table :movies
  end
end
