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
