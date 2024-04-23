class ChatroomPolicy < ApplicationPolicy
  def show?
    record.users.include?(user)
  end

  class Scope < Scope
    def resolve
      scope.joins(:chatroom_members).where(chatroom_members: { user: })
    end
  end
end
