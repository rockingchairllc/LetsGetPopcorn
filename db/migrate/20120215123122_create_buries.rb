class CreateBuries < ActiveRecord::Migration
  def self.up
    create_table :buries do |t|
      t.integer :user_id
      t.integer :viewer_id
      t.string :bury

      t.timestamps
    end
  end

  def self.down
    drop_table :buries
  end
end
