class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title, :keyword
      t.text :body, :meta_description
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
