class AddCreatedByAndUpdatedByToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :created_by, :integer
    add_column :movies, :updated_by, :integer
  end

  def self.down
    remove_column :movies, :updated_by
    remove_column :movies, :created_by
  end
end
