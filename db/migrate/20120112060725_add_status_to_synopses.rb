class AddStatusToSynopses < ActiveRecord::Migration
  def self.up
    add_column :synopses, :status, :integer
  end

  def self.down
    remove_column :synopses, :status
  end
end
