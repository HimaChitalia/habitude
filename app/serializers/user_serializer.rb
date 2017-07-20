class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  has_many :habits
end
