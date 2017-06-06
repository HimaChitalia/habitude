class User < ApplicationRecord

  attr_accessor :skip_password_validation

  has_secure_password

  validate :validate_password_length

  # validates :password, length: { minimum: 6 }, unless: :skip_password_validation
  # validates :password, :presence => true,
  #                      :confirmation => true,
  #                      :length => { minimum: 6 },
  #                      :unless => :already_has_password?
  validates :name, :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  enum role: [:viewer, :user, :admin, :owner]

  has_many :habits
  has_many :goals, through: :habits
  has_many :ideas, through: :habits

  def self.find_or_create_by_omniauth(auth_hash)
   self.where(email: auth_hash[:email]).first_or_create do |u|
     u.name = auth_hash[:name]
     u.password = SecureRandom.hex
     u.role = 2
     u.save
   end
  end

  def validate_password_length
    !password_digest_changed? || password_digest.length >= 6
  end

  def password_digest_changed
    if session[:user_id].present? && params[:user][:password].present?
    end
  end
end
