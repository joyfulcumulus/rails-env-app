class ClaimsController < ApplicationController

  def new
    @claim = Claim.new
    authorize @claim
    @total_points = TotalPoint.find_by(user: current_user)
    @title = "Claim CDC Vouchers"
    render layout: "internalpage_layout"
  end

  def create
    points_used = params[:totalPointsUsed]
    @claim = Claim.new(points: points_used, cdc_voucher_value: points_used / 5, user_id: current_user.id)
    authorize @claim
    @claim.save!

    # Deduct points from user's total_points record after successful save
    @total_points = TotalPoint.find_by(user: current_user)
    new_balance = @total_points.total_points - points_used
    @total_points.update!(total_points: new_balance)

    # respond back both actions okay
    respond_to do |format|
      format.json { render json: { newUserPoints: new_balance }, status: :ok }
    end
  end
end
