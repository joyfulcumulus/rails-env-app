class ChatroomsController < ApplicationController

  def index
    @chatrooms = policy_scope(Chatroom).includes({challenge: { cover_attachment: :blob } }, :estate)
    @title = "Collaboration Chats"
    @back_path = challenges_path
    render layout: "internalpage_layout"
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    authorize @chatroom
    @messages = @chatroom.messages.includes([:user])
    @message = Message.new
    render layout: "chat_layout"
  end

end
