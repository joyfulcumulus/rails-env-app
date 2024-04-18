class ClaimPolicy < ApplicationPolicy

  def new?
    true # default for now
  end

  def create?
    true # default for now
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
