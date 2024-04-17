class ChallengePolicy < ApplicationPolicy
  class Scope < Scope
    def show?
      true
    end

    def new?
      record.user.admin == true
    end

    def create?
      record.user.admin == true
    end

    def edit?
      record.user.admin == true
    end

    def update?
      record.user.admin == true
    end

    def destroy?
      record.user.admin == true
    end

    def resolve
      scope.all
    end
  end
end
