class CreateShowmovies < ActiveRecord::Migration
  def self.up
    create_table :showmovies do |t|
      t.integer :movieid
      t.integer :user_id
      t.datetime :showdate

      t.timestamps
    end
  end

  def self.down
    drop_table :showmovies
  end
end
