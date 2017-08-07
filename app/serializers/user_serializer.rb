class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  has_many :habits
  has_many :comments
end
