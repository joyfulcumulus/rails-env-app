class AwardPointsJob < ApplicationJob
  queue_as :default

  def perform
    puts "Check if points can be awarded based on participant's total recycling rate"
    challenge = Challenge.find_by(name: "National Recycling Challenge")
    latest_event = ChallengeEvent.where(challenge:).where("end_datetime < ?", Date.today.to_datetime).order(end_datetime: :desc).first
    estates = Estate.all
    estates.each do |estate|
      users_in_estate = User.includes(:address).where(address: { estate: })
      total_recyclable_waste = Action.includes(:user)
                                      .where(challenge_event: latest_event)
                                      .where(users: { id: users_in_estate.map(&:id) })
                                      .sum(:recyclable_weight)
      total_waste = users_in_estate.count * 6.0 # assume in this project, weekly waste generated is 6.0kg / user
      latest_recycling_rate = total_recyclable_waste / total_waste * 100
      puts "Recycling rate for estate #{estate.name} is #{latest_recycling_rate}%."

      rewards_programme_targets = RewardsProgramme.where(challenge:).order(target: :asc).pluck(:target)
      achieved_target = rewards_programme_targets.min_by { |target| (latest_recycling_rate - target).abs }
      points_for_user = RewardsProgramme.where(challenge:, target: achieved_target).pluck(:points).first
      puts "Points to give each user: #{points_for_user}"

      if points_for_user.positive?
        users_in_estate.each do |user|
          participation = Participation.find_by(user:, challenge:)
          participation.update!(points: (participation.points + points_for_user))
          total_points = TotalPoint.find_by(user:)
          total_points.update!(total_points: (total_points.total_points + points_for_user))
          PointsAward.create!(points: points_for_user, user:, challenge:, challenge_event: latest_event)
          # log the points award inside points award table
        end
        puts "Points awarded to each user in estate #{estate.name}!"
      else
        puts "No points for user as targets not hit"
      end
    end
  end
end
