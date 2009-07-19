class CreateAttendees < ActiveRecord::Migration
  def self.up
    create_table :attendees do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :organization
      t.string :website
      t.string :tshirt_size
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :attendees
  end
end
