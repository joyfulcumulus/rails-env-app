class Admin::MetricsController < ApplicationController

  def dashboard
    authorize :metric, :dashboard? # headless metric policy, retrieve dashboard? method
    render layout: "admin_layout"
  end

  def award_points
    authorize :metric, :award_points?
    AwardPointsJob.perform_now
    respond_to do |format|
      format.json { render json: { message: "Job triggered successfully" }, status: :ok }
    end
  end
end
