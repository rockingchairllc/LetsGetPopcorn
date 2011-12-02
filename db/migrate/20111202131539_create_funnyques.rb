class CreateFunnyques < ActiveRecord::Migration
  def self.up
    create_table :funnyques do |t|
      t.text :title
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :funnyques
  end
end
