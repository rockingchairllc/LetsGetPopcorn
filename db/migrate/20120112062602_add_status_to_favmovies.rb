class AddStatusToFavmovies < ActiveRecord::Migration
  def self.up
    add_column :favmovies, :status, :integer
  end

  def self.down
    remove_column :favmovies, :status
  end
end
