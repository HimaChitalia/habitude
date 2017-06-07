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

reading = Habit.new
reading.name = "Reading"
reading.category = Category.find_by(name: "Hobbies")
reading.description = "Reading a book at least 2 pages everyday."
reading.create_goal(description: "Should develop this in 3 weeks.")
reading.user = User.find_by(name: "Hima")
reading.goal.milestones.create(description: "Week 1")
reading.goal.milestones.create(description: "Week 2")
reading.goal.milestones.create(description: "Week 3")
reading.save

coding = Habit.new
coding.name = "Coding"
coding.category = Category.find_by(name: "Education")
coding.description = "Learn coding to be web developer."
coding.create_goal(description: "Should develop this in 4 months.")
coding.user = User.find(12)
coding.goal.milestones.create(description: "Month 1")
coding.goal.milestones.create(description: "Month 2")
coding.goal.milestones.create(description: "Month 3")
coding.save

planting = Habit.new
planting.name = "Planting"
planting.category = Category.find_by(name: "Outdoor Recreation")
planting.description = "Give back to nature regularly"
planting.create_goal(description: "Should develop this in 1 year")
planting.user = User.find(13)
planting.goal.milestones.create(description: "Month 3")
planting.goal.milestones.create(description: "Month 6")
planting.goal.milestones.create(description: "Month 9")
planting.goal.milestones.create(description: "Month 12")
planting.save
