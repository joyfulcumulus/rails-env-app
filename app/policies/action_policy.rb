class ActionPolicy < ApplicationPolicy
  def new?
    record.user == user
  end

  def create?
    record.user == user
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
