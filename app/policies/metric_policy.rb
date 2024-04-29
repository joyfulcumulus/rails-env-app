class MetricPolicy < ApplicationPolicy

  def dashboard?
    user.admin?
  end

  def award_points?
    user.admin?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
