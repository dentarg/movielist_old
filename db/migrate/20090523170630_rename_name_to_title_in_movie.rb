class RenameNameToTitleInMovie < ActiveRecord::Migration
  def self.up
    rename_column :movies, :name, :title
    rename_column :movies, :name_sv, :title_sv
  end

  def self.down
    rename_column :movies, :title, :name
    rename_column :movies, :title_sv, :name_sv
  end
end
