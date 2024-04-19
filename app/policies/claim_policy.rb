class ClaimPolicy < ApplicationPolicy
  def new?
    true # anyone can open the claim page
  end

  def create?
    record.user == user # the claim record created must be the current user in this session
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
