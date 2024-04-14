class ChallengesController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home

  def index
    @challenges = policy_scope(Challenge)
  end
end
