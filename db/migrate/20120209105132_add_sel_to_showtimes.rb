class AddSelToShowtimes < ActiveRecord::Migration
  def self.up
    add_column :showtimes, :seltime, :string
  end

  def self.down
    remove_column :showtimes, :seltime
  end
end
