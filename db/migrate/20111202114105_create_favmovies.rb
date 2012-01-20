class CreateFavmovies < ActiveRecord::Migration
  def self.up
    create_table :favmovies do |t|
      t.text :title
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :favmovies
  end
end
