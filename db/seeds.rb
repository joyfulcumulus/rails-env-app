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
Message.destroy_all
ChatroomMember.destroy_all
Chatroom.destroy_all
Claim.destroy_all
Action.destroy_all
ChallengeEvent.destroy_all
Participation.destroy_all
Location.destroy_all
RewardsProgramme.destroy_all
Challenge.destroy_all
User.destroy_all
Address.destroy_all
Estate.destroy_all

puts "creating entries..."

# create estates
estate1 = Estate.create!(
  name: "Tampines",
  zipcode_prefix: "52"
)

estate2 = Estate.create!(
  name: "Pasir Ris",
  zipcode_prefix: "51"
)

estate3 = Estate.create!(
  name: "Hougang",
  zipcode_prefix: "54"
)

puts "estates created..."

# create 15 users with addresses each in Tampines (5), Pasir Ris (5), Hougang (5)

5.times do

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

  Address.create!(
    street: "Tampines Street #{rand(80..98)}",
    zipcode: %w[521895 529651 529393 528482 528588].sample,
    unit_number: "0#{rand(1..9)}-1124",
    estate: estate1
  )
end

puts "users created..."

# make 2 users admin

puts "2 users become admin..."


# create challenges

puts "challenges created..."

# create rewards programme

puts "rewards programme created..."

# create locations

puts "locations created..."

# create challenge events

puts "challenge events created..."

# create chatrooms

puts "chatrooms created..."

puts "seeding entries done!"
