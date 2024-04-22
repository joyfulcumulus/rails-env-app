class ChatroomPolicy < ApplicationPolicy
  def show?
    true # temporarily allow all users to see all chatrooms
  end

  class Scope < Scope
    def resolve
      scope.all # temporarily allow all users to see all chatrooms
    end
  end
end
