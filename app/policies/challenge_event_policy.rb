class ChallengeEventPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def new?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def show?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def points_history?
    true # temporarily allow
  end

  def recycled_history?
    true # temporarily allow
  end

  def waste_per_event?
    true # temporarily allow
  end

  def recycling_vol_per_event?
    true # temporarily allow
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.none
      end
    end
  end
end
