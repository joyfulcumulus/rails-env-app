class ChatroomsController < ApplicationController

  def index
    @chatrooms = policy_scope(Chatroom)
    @title = "Collaboration Chats"
    render layout: "internalpage_layout"
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    authorize @chatroom
    @message = Message.new
    render layout: "chat_layout"
  end

end
