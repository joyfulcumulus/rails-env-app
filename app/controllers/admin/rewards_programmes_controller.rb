class Admin::RewardsProgrammesController < ApplicationController

  def create
    @reward = RewardsProgramme.new(params_reward)
    @challenge = Challenge.find(params[:challengeId])
    @reward.challenge = @challenge
    authorize @reward

    respond_to do |format|
      if @reward.save
        format.json { render json: { message: "ok" }, status: :ok }
      else
        format.json { render json: { message: "not ok" }, status: :unprocessable_entity }
      end
      # format.html { redirect_to edit_admin_challenge_path(@challenge) }
    end
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
