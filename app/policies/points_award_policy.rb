class PointsAwardPolicy < ApplicationPolicy
  def points_history?
    true # temporarily put as true
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
