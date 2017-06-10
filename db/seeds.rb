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

# Create wikis
50.times do
  Wiki.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end
wiki = Wiki.all

puts "Seed finished"
puts "#{Wiki.count} wikis created"
