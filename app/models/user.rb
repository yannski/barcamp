class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :admin, :type => Boolean, :default => false, :accessible => false

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  # :registerable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

end
