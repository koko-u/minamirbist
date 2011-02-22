class AddOrganizerToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :organizer, :integer
  end

  def self.down
    remove_column :events, :organizer
  end
end
