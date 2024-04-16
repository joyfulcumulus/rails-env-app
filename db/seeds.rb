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
  name: "Hougang",
  zipcode_prefix: "54"
)

puts "estates created..."

# create challenges

recycling_challenge = Challenge.create!(
  name: "National Recycling Challenge",
  description: "The National Recycling Challenge is a nation-wide effort to become more sustainable. Increase the recycling rate of your estate in collaboration with your neighbours and collect points, which can be converted into CDC vouchers!\n Points are given based on the recycling rate attained by the estate.",
  participant_criteria: "Any household",
  start_date: Time.new(2024, 6, 1, 0, 0, 0, "+08:00"),
  end_date: Time.new(2024, 12, 31, 23, 59, 59, "+08:00")
)

puts "challenges created..."

# create rewards programme

recycling_rewards1 = RewardsProgramme.create!(
  target: 22,
  unit_of_measurement: "%",
  points: 5,
  challenge: recycling_challenge
)

recycling_rewards2 = RewardsProgramme.create!(
  target: 23,
  unit_of_measurement: "%",
  points: 5,
  challenge: recycling_challenge
)

recycling_rewards3 = RewardsProgramme.create!(
  target: 24,
  unit_of_measurement: "%",
  points: 10,
  challenge: recycling_challenge
)

recycling_rewards4 = RewardsProgramme.create!(
  target: 25,
  unit_of_measurement: "%",
  points: 10,
  challenge: recycling_challenge
)

recycling_rewards5 = RewardsProgramme.create!(
  target: 26,
  unit_of_measurement: "%",
  points: 15,
  challenge: recycling_challenge
)

recycling_rewards6 = RewardsProgramme.create!(
  target: 27,
  unit_of_measurement: "%",
  points: 15,
  challenge: recycling_challenge
)

recycling_rewards7 = RewardsProgramme.create!(
  target: 28,
  unit_of_measurement: "%",
  points: 20,
  challenge: recycling_challenge
)

recycling_rewards8 = RewardsProgramme.create!(
  target: 29,
  unit_of_measurement: "%",
  points: 20,
  challenge: recycling_challenge
)

recycling_rewards9 = RewardsProgramme.create!(
  target: 30,
  unit_of_measurement: "%",
  points: 25,
  challenge: recycling_challenge
)

puts "rewards programme created..."

# create locations

recycling_address1 = Address.create!(
  street: "232 Tampines Street 21",
  zipcode: "521232",
  unit_number: "01-639",
  estate: estate1
)

recycling_location1 = Location.create!(
  challenge: recycling_challenge,
  address: recycling_address1
)

recycling_address2 = Address.create!(
  street: "842 Tampines Street 82",
  zipcode: "520842",
  estate: estate1
)

recycling_location2 = Location.create!(
  challenge: recycling_challenge,
  address: recycling_address2
)

recycling_address3 = Address.create!(
  street: "21 Tampines Avenue 1, Temasek Polytechnic",
  zipcode: "529757",
  estate: estate1
)

recycling_location3 = Location.create!(
  challenge: recycling_challenge,
  address: recycling_address3
)

recycling_address4 = Address.create!(
  street: "1 Tampines Walk, Our Tampines Hub, Fairprice",
  zipcode: "528523",
  unit_number: "B1-01",
  estate: estate1
)

recycling_location4 = Location.create!(
  challenge: recycling_challenge,
  address: recycling_address4
)

recycling_address5 = Address.create!(
  street: "9 Tampines Avenue 2, Shell",
  zipcode: "529731",
  estate: estate1
)

recycling_location5 = Location.create!(
  challenge: recycling_challenge,
  address: recycling_address5
)

puts "locations created..."

# create challenge events

puts "challenge events created..."

# create chatrooms

puts "chatrooms created..."

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


puts "seeding entries done!"
