class ClaimsController < ApplicationController

  def new
    @claim = Claim.new
    authorize @claim
    @title = "Claim CDC Vouchers"
    render layout: "internalpage_layout"
  end


end
