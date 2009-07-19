class Attendee < ActiveRecord::Base
  has_attached_file :avatar,
                    :styles => { :small => '48x48\>', :medium => '100x100\>', :large => '130x130\>' },
                    :default_style => :small
  validates_attachment_size         :avatar, :less_than => 1.megabyte
  validates_attachment_content_type :avatar, :content_type => /(image\/(gif|jpg|jpeg|png|pjpeg|x-png))/
end
