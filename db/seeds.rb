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

markdn_wiki = Wiki.create(
  title: "My Markdown Wiki Example",
  private: false,
  user: users.sample,
  body:
  %Q{#My Markdown Wiki Body H1 here#
##Markdown CheatSheet H2 here##
###Testing the markdown renderer H3 here###

  *italic*
  **bold**

1. First ordered list item
2. Another item
3. Another number
4. And another item

* Unordered list can use asterisks
* another item in list

⋅⋅⋅To have a line break without a paragraph, use two trailing spaces.⋅⋅

  ```A code block.```
  }
)

wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
puts "Private wiki created by #{users.last}"
