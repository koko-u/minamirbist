class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :twitter
      t.string :blog
      t.date :birthday
      t.text :profile

      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
