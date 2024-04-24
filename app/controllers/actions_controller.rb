class ActionsController < ApplicationController

  def new
    @challenge_event = ChallengeEvent.find(params[:challenge_event_id])
    @user = current_user
    @recyclable_weight = rand(78..150) / 100.00
    @action = Action.new(recyclable_weight: @recyclable_weight, user: @user, challenge_event: @challenge_event)
    authorize @action
  end

  def create
    raise
  end

end
