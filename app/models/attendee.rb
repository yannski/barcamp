class Attendee
  include Mongoid::Document
  include Mongoid::Timestamps
  include Paperclip

  field :first_name
  field :last_name
  field :email
  field :organization
  field :website
  field :tshirt_size
  field :tags, :type => Array

  field :avatar_file_name
  field :avatar_file_type
  field :avatar_file_size, :type => Integer
  field :avatar_updated_at, :type => Time

  has_attached_file :avatar,
                    :styles => { :small => '48x48\>', :medium => '100x100\>', :large => '130x130\>' },
                    :default_style => :small,
                    :default_url => "/images/default_:style_avatar.png"

  validates_presence_of :first_name
  validates_presence_of :last_name

  def tags=(txt)
    write_attribute(:tags, txt.split(",")[0,3]) if txt.present?
  end

  def tags
    txt = read_attribute(:tags)
    txt.join(", ") rescue ""
  end
end
