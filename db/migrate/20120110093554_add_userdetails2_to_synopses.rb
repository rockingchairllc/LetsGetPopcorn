class AddUserdetails2ToSynopses < ActiveRecord::Migration
  def self.up
    add_column :synopses, :supporting_actor, :text
  end

  def self.down
    remove_column :synopses, :supporting_actor
  end
end
