class AddHeaderTitleToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :header_title, :string
  end

  def self.down
    remove_column :pages, :header_title
  end
end
