class MovieNightsUsers < ActiveRecord::Migration
  def self.up
    create_table :movie_nights_users, :id => false do |t|
      t.belongs_to :movie_night
      t.belongs_to :user
    end
  end

  def self.down
    drop_table :movie_nights_users
  end
end
