include Faker

50.times do
  User.create!(
  email: Faker::Internet.email,
  password: Faker::Internet.password
  )
end
# seed with standard, admin, and premium

User.create!(email: "admin@example.com", role: "admin", password: "helloworld")
User.create!(email: "premium@example.com", role: "premium", password: "helloworld")
User.create!(email: "standard@example.com", role: "standard", password: "helloworld")

users = User.all
50.times do
  Wiki.create!(
  title: Faker::Lorem.sentence,
  body: Faker::Lorem.paragraph,
  user: users.sample
  )
end

wikis = Wiki.all

puts "Seed finished"
puts "#{Wiki.count} wikis created"
