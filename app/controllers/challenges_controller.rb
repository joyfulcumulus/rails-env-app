class ChallengesController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home

  def index
    @challenges = policy_scope(Challenge)
    @challenges_participated = current_user.challenges
    @total_points = TotalPoint.find_by(user: current_user)
    @title = "Challenges"
    render layout: "subpage_layout"
  end

  def show
    @challenge = Challenge.find(params[:id])
    authorize @challenge
    @rewards_programmes = RewardsProgramme.where(challenge: @challenge)
    if @challenge.metric_objective == "maximize"
      @final_target_metric = @rewards_programmes.maximum(:target)
    else
      @final_target_metric = @rewards_programmes.minimum(:target)
    end
    @latest_estate_metric = latest_estate_metric
    @title = "Challenge Details"
    render layout: "challenge_layout"
  end

  def new
    @challenge = Challenge.new
    authorize @challenge
  end

  def create
    @challenge = Challenge.new(params_challenge)
    authorize @challenge
    @challenge.user = current_user
    if @challenge.save
      redirect_to challenges_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @challenge = Challenge.find(params[:id])
    authorize @challenge
  end

  def update
    @challenge = Challenge.find(params[:id])
    authorize @challenge
    @challenge.update(params_challenge)
    redirect_to challenge_path(@challenge)
  end

  def destroy
    @challenge = Challenge.find(params[:id])
    authorize @challenge
    @challenge.destroy
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
      format.json { render json: { message: "ok" }, status: :ok }
    end
  end

  private

  def params_challenge
    params.require(:challenge).permit(:name, :description, :participant_criteria, :start_date, :end_date, :cover [])
  end

  def latest_estate_metric
    latest_event = ChallengeEvent.where("end_datetime < ?", Date.today.to_datetime).order(end_datetime: :desc).first
    # TO DO: amend above statement to filter by challenge, now always taking latest challenge regardless of type
    user_estate = current_user.address.estate
    users_in_estate = User.includes(:address).where(address: { estate: user_estate })
    total_recyclable_waste = Action.includes(:user)
                                    .where(challenge_event: latest_event)
                                    .where(users: { id: users_in_estate.map(&:id) })
                                    .sum(:recyclable_weight)
    total_waste = users_in_estate.count * 6.0
    recycling_rate = total_recyclable_waste / total_waste
  end
end
