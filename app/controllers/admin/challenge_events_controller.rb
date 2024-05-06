class Admin::ChallengeEventsController < ApplicationController
  def index
    @challenge_events = []
    if params[:challenge_id].present?
      @challenge = Challenge.find(params[:challenge_id])
      @challenge_events = policy_scope(ChallengeEvent).where(challenge: @challenge).order(end_datetime: :asc)
    end
    render layout: "admin_layout"
  end

  def create
    @challenge_event = ChallengeEvent.new(params_challenge_event)
    authorize @challenge_event
    if @challenge_event.save!
      redirect_to admin_challenge_events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @challenge_event = ChallengeEvent.new
    authorize @challenge_event
    render layout: "admin_layout"
  end

  def edit
    @challenge_event = ChallengeEvent.find(params[:id])
    authorize @challenge_event
    render layout: "admin_layout"
  end

  def show
    @challenge_event = ChallengeEvent.find(params[:id])
    authorize @challenge_event
    url = url_for(action: 'new', controller: '/actions', challenge_event_id: @challenge_event.id)
    @qr_code = RQRCode::QRCode.new(url)
    @svg = @qr_code.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      standalone: true,
      module_size: 8
    )
  end

  def update
    @challenge_event = ChallengeEvent.find(params[:id])
    authorize @challenge_event
    @challenge_event.update(params_challenge_event)
    redirect_to admin_challenge_events_path
  end

  def destroy
    @challenge_event = ChallengeEvent.find(params[:id])
    authorize @challenge_event
    @challenge_event.destroy
    redirect_to admin_challenge_events_path
  end

  private

  def params_challenge_event
    params.require(:challenge_event).permit(:start_datetime, :end_datetime, :challenge_id)
  end
end
