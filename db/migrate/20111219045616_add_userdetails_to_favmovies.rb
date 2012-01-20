class AddUserdetailsToFavmovies < ActiveRecord::Migration
  def self.up
    add_column :favmovies, :height_feet, :string
    add_column :favmovies, :height_inches, :string
    add_column :favmovies, :smoke, :string
    add_column :favmovies, :drink, :string
  end

  def self.down
    remove_column :favmovies, :drink
    remove_column :favmovies, :smoke
    remove_column :favmovies, :height_inches
    remove_column :favmovies, :height_feet
  end
end
