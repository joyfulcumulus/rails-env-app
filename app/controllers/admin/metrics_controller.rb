class Admin::MetricsController < ApplicationController

  def dashboard
    authorize :metric, :dashboard? # headless metric policy, retrieve dashboard? method
    @title = "Admin Dashboard"
    render layout: "internalpage_layout"
  end

  def award_points
    AwardPointsJob.perform_now
    render json: { message: "Job triggered successfully" }
  end

end
