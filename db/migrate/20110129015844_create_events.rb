class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.date :date_on
      t.string :place
      t.text :contents

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
