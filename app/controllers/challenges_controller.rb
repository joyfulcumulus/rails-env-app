class ChallengesController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home

  def index
    @challenges = policy_scope(Challenge).includes([cover_attachment: :blob]).order(start_date: :asc)
    @challenges_participated = current_user.challenges
    @total_points = TotalPoint.find_by(user: current_user)
    @title = "Challenges"
    render layout: "subpage_layout"
  end

  def show
    @challenge = Challenge.find(params[:id])
    authorize @challenge
    @num_participants = @challenge.users.includes(:address).where(address: { estate: current_user.address.estate }).count
    @rewards_programmes = RewardsProgramme.where(challenge: @challenge)
    @final_target_metric = @challenge.metric_objective == "maximize" ? @rewards_programmes.maximum(:target) : @rewards_programmes.minimum(:target)
    @latest_estate_metric = @challenge.name == "National Recycling Challenge" ? metric_fr_actions(params[:id]) : 0
    @chatroom = Chatroom.joins(:chatroom_members).where(chatroom_members: { user: current_user }).where(challenge: @challenge).first
    @title = "Challenge Details"
    @back_path = challenges_path
    render layout: "challenge_layout"
  end

  def join
    @user = current_user
    @challenge = Challenge.find(params[:id])
    @participation = Participation.new(user: @user, challenge: @challenge)
    authorize @participation
    @participation.save!

    @user_estate = @user.address.estate
    @chatroom = Chatroom.find_or_initialize_by(challenge: @challenge, estate: @user_estate)
    @chatroom.save!

    @chatroom_member = ChatroomMember.find_or_initialize_by(user: @user, chatroom: @chatroom)
    authorize @chatroom_member
    @chatroom_member.save!

    respond_to do |format|
      # return chatroom ID for newly joined member to access
      format.json { render json: { chatroomId: @chatroom.id }, status: :ok }
    end
  end

  def points_history
    challenge = Challenge.find(params[:id])
    @recent_points_history =
      ChallengeEvent
      .joins("LEFT JOIN points_awards ON challenge_events.id = points_awards.challenge_event_id AND points_awards.user_id = #{current_user.id}")
      .where(challenge:)
      .where("end_datetime < ?", Date.today.to_datetime)
      .where("end_datetime > ?", Date.today.weeks_ago(6).to_datetime)
      .order(end_datetime: :asc)
      .select('challenge_events.end_datetime, points_awards.points as points')
    authorize @recent_points_history
    respond_to :json
  end

  def recycled_history
    challenge = Challenge.find(params[:id])
    @recent_recycled_history =
      ChallengeEvent
      .joins("LEFT JOIN actions ON challenge_events.id = actions.challenge_event_id AND actions.user_id = #{current_user.id}")
      .where(challenge:)
      .where("end_datetime < ?", Date.today.to_datetime)
      .where("end_datetime > ?", Date.today.weeks_ago(6).to_datetime)
      .order(end_datetime: :asc)
      .select('challenge_events.end_datetime, actions.recyclable_weight as weight')
    authorize @recent_recycled_history
    respond_to :json
  end

  def metric_fr_actions(challenge_id)
    latest_event = ChallengeEvent.where(challenge_id:).where("end_datetime < ?", Date.today.to_datetime).order(end_datetime: :desc).first
    user_estate = current_user.address.estate
    users_in_estate = User.includes(:address).where(address: { estate: user_estate })
    total_recyclable_waste =
      Action
      .includes(:user)
      .where(challenge_event: latest_event)
      .where(users: { id: users_in_estate.map(&:id) })
      .sum(:recyclable_weight)
    total_waste = users_in_estate.count * 6.0 # assume in this project, weekly waste generated is 6.0kg / user
    return total_recyclable_waste / total_waste
  end
  helper_method :metric_fr_actions

end
