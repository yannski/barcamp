class CreateAttendees < ActiveRecord::Migration
  def self.up
    create_table :attendees do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :organization
      t.string :website
      t.string :tshirt_size

      t.timestamps
    end
  end

  def self.down
    drop_table :attendees
  end
end
