class Admin::MetricsController < ApplicationController

  def dashboard

  end

  def award_points
    AwardPointsJob.perform_now
    render json: { message: "Job triggered successfully" }
  end

end
