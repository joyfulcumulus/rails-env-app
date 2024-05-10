class Admin::MetricsController < ApplicationController
  def dashboard
    authorize :metric, :dashboard? # headless metric policy, retrieve dashboard? method
    render layout: "admin_layout"
  end

  def users_per_event
  #   challenge_events_in_range =
  #   ChallengeEvent
  #   .where(challenge:)
  #   .where("end_datetime < ?", )
  #   .where("end_datetime > ?", )
  #   .order(end_datetime: :asc)

  # @num_participants =
  #   Action
  #   .includes(:user)
  #   .where(challenge_event: latest_event)
  #   .where(users: { id: users_in_estate.map(&:id) })
  #   .sum(:recyclable_weight)
  #   authorize @num_participants
  #   respond_to :json
  end

  def recycling_rate_per_event
  end

  def recycling_vol_per_event
  end

  def waste_per_event
    challenge_id = JSON.parse(params[:challengeId])
    estate_id = JSON.parse(params[:estateId])
    start_date = JSON.parse(params[:startDate])
    end_date = JSON.parse(params[:endDate])

    @events_in_range =
      ChallengeEvent
      .where(challenge: Challenge.find(challenge_id))
      .where("end_datetime < ?", Date.parse(end_date))
      .where("end_datetime > ?", Date.parse(start_date))
      .order(end_datetime: :asc)
      .select(:end_datetime)
    authorize @events_in_range

    @num_residents_in_estate = User.includes(:address).where(address: { estate: Estate.find(estate_id) }).count

    respond_to :json
  end

  def award_points
    authorize :metric, :award_points?
    AwardPointsJob.perform_now
    respond_to do |format|
      format.json { render json: { message: "Job triggered successfully" }, status: :ok }
    end
  end
end
