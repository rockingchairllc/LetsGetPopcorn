class CreateProfileviews < ActiveRecord::Migration
  def self.up
    create_table :profileviews do |t|
      t.integer :user_id
      t.integer :viewer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :profileviews
  end
end