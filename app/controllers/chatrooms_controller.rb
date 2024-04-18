class ChatroomsController < ApplicationController

  def index
    @chatrooms = policy_scope(Chatroom)
  end

end
