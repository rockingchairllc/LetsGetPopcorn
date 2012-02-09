class CreateShowtimes < ActiveRecord::Migration
  def self.up
    create_table :showtimes do |t|
      t.integer :movieid
      t.integer :theatreid
      t.datetime :showdate
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :showtimes
  end
end
