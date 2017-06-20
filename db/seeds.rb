# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
require 'random_data'

# Create an admin user
  admin = User.create!(
    email: 'admin@test.com',
    password: 'nonono',
    role: 'admin'
  )

# Create a standard user
  standard = User.create!(
    email: 'standard@test.com',
    password: 'nonono',
    role: 'standard'
 )

# Create users
5.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password(8)
  )
end
users = User.all

# Create wikis
50.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph(3),
    private: false,
    user: users.sample
  )
end

private_wiki = Wiki.create(
    title: "Private wiki",
    body: Faker::Lorem.paragraph,
    private: true,
    user: users.last
)
wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
puts "Private wiki created by #{users.last}"
