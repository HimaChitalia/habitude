class User < ApplicationRecord

  has_secure_password

  has_many :habits
  has_many :goals, through: :habits
  has_many :ideas, through: :habits

  def self.find_or_create_by_omniauth(auth_hash)
     self.where(email: auth_hash[‘info’][‘email’]).first_or_create do |u|
     u.name = auth_hash[‘info’][‘name’]
     u.password = SecureRandom.hex
     end
 end

end
