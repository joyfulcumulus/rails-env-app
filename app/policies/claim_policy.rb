class ClaimPolicy < ApplicationPolicy
  def new?
    true # anyone can open the claim page
  end

  def create?
    true # anyone can create a claim
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
