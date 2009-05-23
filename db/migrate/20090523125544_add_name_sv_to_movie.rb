class AddNameSvToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :name_sv, :string
  end

  def self.down
    remove_column :movies, :name_sv
  end
end
