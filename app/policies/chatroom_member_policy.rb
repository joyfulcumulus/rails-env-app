class ChatroomMemberPolicy < ApplicationPolicy
  def join?
    record.user == user # person who joined the chatroom must be the current user
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
