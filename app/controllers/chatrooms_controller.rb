class ChatroomsController < ApplicationController

  def index
    @chatrooms = policy_scope(Chatroom)
    @title = "Collaboration Chats"
    render layout: "internalpage_layout"
  end

end
