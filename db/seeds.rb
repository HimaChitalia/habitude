# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

10.times do
  User.create(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length = 8, max_length = 16),
    role: [2, 3].sample
  )
end

hima = User.new
hima.name = "Hima"
hima.email = "h@hima.com"
hima.password = "himapassword"
hima.role = 4
hima.save

baani = User.new
baani.name = "Baani"
baani.email = "b@baani.com"
baani.password = "baanipassword"
baani.role = 1
baani.save

trushal = User.new
trushal.name = "Trushal"
trushal.email = "b@trushal.com"
trushal.password = "trushalpassword"
trushal.role = 2
trushal.save

vinit = User.new
vinit.name = "Vinit"
vinit.email = "V@vinit.com"
vinit.password = "vinitpassword"
vinit.role = 3
vinit.save

categories = ["Money", "Health and Fitness", "The Arts", "Outdoor Recreation", "Education", "Business", "Wellness", "Hobbies"]

categories.each do |category|
  c = Category.new(name: category)
  c.save
end
