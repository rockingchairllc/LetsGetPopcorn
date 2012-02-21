class CreateFuturecitydemands < ActiveRecord::Migration
  def self.up
    create_table :futurecitydemands do |t|
      t.string :zipcode
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :futurecitydemands
  end
end
