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

categories = ["Money", "Health and Fitness", "The Arts", "Outdoor Recreation", "Education", "Business", "Wellness", "Hobbies", "Relationship", "Productivity", "Professional", "Kick a Habit"]

categories.each do |category|
  c = Category.new(name: category)
  c.save
end

goals = ["Should develop this in 1 week.", "Should develop this in 2 weekS.", "Should develop this in 3 weeks.", "Should develop this in 4 weeks." ]

goals.each do |goal|
  g = Goal.new(name: goal)
  g.save
end

milestones = ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5", "Day 6", "Day 7", "Day 8", "Day 9", "Day 10", "Day 11", "Day 12", "Day 13", "Day 14",
"Day 15", "Day 16", "Day 17", "Day 18", "Day 19", "Day 21", "Day 22", "Day 23", "Day 24", "Day 25", "Day 26", "Day 27",
"Day 28", "Day 29", "Day 30", "Day 31 - The final day" "Week 1", "Week 2", "Week 3", "Week 4"]

milestones.each do |milestone|
  m = Milestone.new(description: milestone)
  m.save
end

statuses = ["Not as per expectations", "Much better than I expected.", "Awesome up till now", "Need to try harder", "NOt interested anymore"]

statuses.each do |status|
  s = Status.new(description: status)
  s.save
end

reading = Habit.new
reading.name = "Reading"
reading.category = Category.find_by(name: "Hobbies")
reading.description = "Reading a book at least 2 pages everyday."
reading.user = User.find_by(name: "Hima")
goal = Goal.find(1)
reading.goals << goal
milestone = Milestone.first
reading.goals.first.milestones << milestone
reading.save

coding = Habit.new
coding.name = "Coding"
coding.category = Category.find_by(name: "Education")
coding.description = "Learn coding to be web developer."
coding.user = User.find(3)
goal = Goal.find(2)
coding.goals << goal
milestone = Milestone.last
coding.goals.first.milestones << milestone
coding.save

planting = Habit.new
planting.name = "Planting"
planting.category = Category.find_by(name: "Outdoor Recreation")
planting.description = "Give back to nature regularly"
goal = Goal.find(3)
planting.goals << goal
planting.user = User.find(1)
milestone = Milestone.find(31)
planting.goals.first.milestones << milestone
planting.save
