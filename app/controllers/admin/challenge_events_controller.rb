class Admin::ChallengeEventsController < ApplicationController
  def index
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
    @challenge_event = ChallengeEvent.find(params[:id])
    authorize @challenge_event
  end

  def update
  end

  def destroy
  end

end
