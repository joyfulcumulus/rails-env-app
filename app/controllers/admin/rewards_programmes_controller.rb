class Admin::RewardsProgrammesController < ApplicationController

  def create
    raise
  end

  def update
    @reward = RewardsProgramme.find(params[:id])
    authorize @reward
    @reward.update(params_reward)
    @challenge = @reward.challenge
    redirect_to edit_admin_challenge_path(@challenge)
  end

  def destroy
    @reward = RewardsProgramme.find(params[:id])
    authorize @reward
    @challenge = @reward.challenge
    @reward.destroy
    redirect_to edit_admin_challenge_path(@challenge)
  end

  private

  def params_reward
    params.require(:rewards_programme).permit(:target, :points)
  end
end
