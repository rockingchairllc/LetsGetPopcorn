class AddDetails2ToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :birthday, :date
    add_column :users, :zip, :string
    add_column :users, :gender, :string
    add_column :users, :orientation, :string
    add_column :users, :overlay, :integer
  end

  def self.down
    remove_column :users, :overlay
    remove_column :users, :orientation
    remove_column :users, :gender
    remove_column :users, :zip
    remove_column :users, :birthday
  end
end
