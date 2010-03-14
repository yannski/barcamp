class AddWarmingToAttendee < ActiveRecord::Migration
  def self.up
    add_column :attendees, :warming, :boolean
  end

  def self.down
    remove_column :attendees, :warming
  end
end
