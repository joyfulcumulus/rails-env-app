class Admin::ChallengesController < ApplicationController
  def index
    @challenges = policy_scope(Challenge).order(start_date: :asc)
    render layout: "admin_layout"
  end

  def show
    @challenge = Challenge.find(params[:id])
    authorize @challenge
    render layout: "admin_layout"
  end

  def new
    @challenge = Challenge.new
    authorize @challenge
    render layout: "admin_layout"
  end

  def create
    @challenge = Challenge.new(params_challenge)
    authorize @challenge
    if @challenge.save
      redirect_to admin_challenges_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @challenge = Challenge.find(params[:id])
    authorize @challenge
    render layout: "admin_layout"
  end

  def update
    @challenge = Challenge.find(params[:id])
    authorize @challenge
    @challenge.update(params_challenge)
    redirect_to admin_challenges_path
  end

  def destroy
    @challenge = Challenge.find(params[:id])
    authorize @challenge
    @challenge.destroy
    redirect_to admin_challenges_path
  end

  private

  def params_challenge
    params.require(:challenge).permit(
      :name, :description, :participant_criteria,
      :start_date, :end_date,
      :metric_name, :metric_objective, :metric_unit,
      :cover
    )
  end
end
