# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "open-uri"

puts "resetting data base..."
Challenge.destroy_all
User.destroy_all

puts "creating entries..."

# create users

user1 = User.create!(
  email: "user1@email.com",
  password: "password",
  first_name: "Melissa",
  last_name: "Li",
  admin: false
)

file = URI.open("https://thispersondoesnotexist.com/")
user1.avatar.attach(io: file, filename: "avatar1.jpeg", content_type: "image/jpeg")
user1.save

user2 = User.create!(
  email: "user2@email.com",
  password: "password",
  first_name: "Melvin",
  last_name: "Tan",
  admin: true
)

file = URI.open("https://thispersondoesnotexist.com/")
user2.avatar.attach(io: file, filename: "avatar2.jpeg", content_type: "image/jpeg")
user2.save

puts "seeding entries done!"
