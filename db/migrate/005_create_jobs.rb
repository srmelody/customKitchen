class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.string :title
      t.date :appliedTo
      t.string :url
      t.references :status

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
