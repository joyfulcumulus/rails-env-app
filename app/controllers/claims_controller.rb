class ClaimsController < ApplicationController

  def new
    @claim = Claim.new
    authorize @claim
    @title = "Claim CDC Vouchers"
    render layout: "internalpage_layout"
  end

  def create
    points_used = params[:totalPointsUsed]
    @claim = Claim.new(points: points_used, cdc_voucher_value: points_used / 5, user_id: current_user.id)
    authorize @claim
    @claim.save

    respond_to do |format|
      format.json { render json: { message: "ok" }, status: :ok }
    end
  end

end
