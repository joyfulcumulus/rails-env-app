class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home

  def home
    @challenges = policy_scope(Challenge).includes([cover_attachment: :blob])
  end
end
