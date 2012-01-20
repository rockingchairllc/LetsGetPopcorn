class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.string :subject_name
      
      t.timestamps
    end
    execute <<-SQL
      INSERT INTO subjects (subject_name) VALUES('Issues with Site');

    SQL


    execute <<-SQL
        INSERT INTO subjects (subject_name) VALUES('Partnership Opportunities');
        
    SQL


    execute <<-SQL
        INSERT INTO subjects (subject_name) VALUES(' Other');
        
    SQL
  end

  def self.down
    drop_table :subjects
  end
end
