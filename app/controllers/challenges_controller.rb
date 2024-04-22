class ChallengesController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home

  def index
    @challenges = policy_scope(Challenge)
    @total_points = TotalPoint.find_by(user: current_user)
    @title = "Challenges"
    render layout: "subpage_layout"
  end

  def show
    @challenge = Challenge.find(params[:id])
    authorize @challenge
    @rewards_programmes = RewardsProgramme.where(challenge: @challenge)
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

  private

  def params_challenge
    params.require(:challenge).permit(:name, :description, :participant_criteria, :start_date, :end_date, :cover [])
  end
end
