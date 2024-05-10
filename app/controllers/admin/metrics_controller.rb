class Admin::MetricsController < ApplicationController
  def dashboard
    authorize :metric, :dashboard? # headless metric policy, retrieve dashboard? method
    render layout: "admin_layout"
  end

  def participants_per_event
    challenge_id = JSON.parse(params[:challengeId])
    estate_id = JSON.parse(params[:estateId])
    start_date = JSON.parse(params[:startDate])
    end_date = JSON.parse(params[:endDate])

    @users_in_estate = User.includes(:address).where(address: { estate: Estate.find(estate_id) }).map(&:id)

    @participants_in_range =
      ChallengeEvent
      .joins("LEFT JOIN actions ON challenge_events.id = actions.challenge_event_id AND actions.user_id IN (#{@users_in_estate.join(",")})")
      .where(challenge: Challenge.find(challenge_id))
      .where("end_datetime < ?", Date.parse(end_date))
      .where("end_datetime > ?", Date.parse(start_date))
      .order(end_datetime: :asc)
      .group(:end_datetime)
      .select('challenge_events.end_datetime, COUNT(DISTINCT actions.user_id) as participants')
    authorize @participants_in_range
    respond_to :json
  end

  def recycling_rate_per_event
    challenge_id = JSON.parse(params[:challengeId])
    estate_id = JSON.parse(params[:estateId])
    start_date = JSON.parse(params[:startDate])
    end_date = JSON.parse(params[:endDate])

    @users_in_estate = User.includes(:address).where(address: { estate: Estate.find(estate_id) }).map(&:id)
    @num_users_in_estate = @users_in_estate.count

    @recycling_rate_in_range =
      ChallengeEvent
      .joins("LEFT JOIN actions ON challenge_events.id = actions.challenge_event_id AND actions.user_id IN (#{@users_in_estate.join(",")})")
      .where(challenge: Challenge.find(challenge_id))
      .where("end_datetime < ?", Date.parse(end_date))
      .where("end_datetime > ?", Date.parse(start_date))
      .order(end_datetime: :asc)
      .group(:end_datetime)
      .select("challenge_events.end_datetime, ( SUM(actions.recyclable_weight) / (#{@num_users_in_estate * 6.0}) ) as recyclingrate")
    authorize @recycling_rate_in_range
    respond_to :json
  end

  def recycling_vol_per_event
    challenge_id = JSON.parse(params[:challengeId])
    estate_id = JSON.parse(params[:estateId])
    start_date = JSON.parse(params[:startDate])
    end_date = JSON.parse(params[:endDate])

    @users_in_estate = User.includes(:address).where(address: { estate: Estate.find(estate_id) }).map(&:id)

    @recycling_vol_in_range =
      ChallengeEvent
      .joins("LEFT JOIN actions ON challenge_events.id = actions.challenge_event_id AND actions.user_id IN (#{@users_in_estate.join(",")})")
      .where(challenge: Challenge.find(challenge_id))
      .where("end_datetime < ?", Date.parse(end_date))
      .where("end_datetime > ?", Date.parse(start_date))
      .order(end_datetime: :asc)
      .group(:end_datetime)
      .select('challenge_events.end_datetime, ( SUM(actions.recyclable_weight) / COUNT(DISTINCT actions.user_id) ) as averagevol')
    authorize @recycling_vol_in_range
    respond_to :json
  end

  def waste_per_event
    challenge_id = JSON.parse(params[:challengeId])
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
