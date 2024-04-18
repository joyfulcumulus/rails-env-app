class ClaimsController < ApplicationController

  def new
    @claim = Claim.new
    authorize @claim
  end


end
