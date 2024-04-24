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
  end

  def destroy
  end

end
