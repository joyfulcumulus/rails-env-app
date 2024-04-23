class ChatroomsController < ApplicationController

  def index
    @chatrooms = policy_scope(Chatroom)
    @title = "Collaboration Chats"
    render layout: "internalpage_layout"
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    authorize @chatroom
    render layout: "chat_layout"
  end

end
