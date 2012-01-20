class CreateSynopses < ActiveRecord::Migration
  def self.up
    create_table :synopses do |t|
      t.text :title
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :synopses
  end
end
