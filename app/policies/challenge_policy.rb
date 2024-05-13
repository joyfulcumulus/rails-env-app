class ChallengePolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    user.admin == true
  end

  def create?
    user.admin == true
  end

  def edit?
    user.admin == true
  end

  def update?
    user.admin == true
  end

  def destroy?
    user.admin == true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
