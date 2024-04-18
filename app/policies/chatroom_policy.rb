class ChatroomPolicy < ApplicationPolicy


  class Scope < Scope
    def resolve
      scope.all # temporarily allow all users to see all chatrooms
    end
  end
end
