class ParticipationPolicy < ApplicationPolicy
  def join?
    record.user == user # the participation record created must be the current user in this session
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
