class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    authorize @message
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        sender: current_user.id,
        message: render_to_string(partial: "message", locals: { message: @message })
      )
      head :ok
    else
      @messages = @chatroom.messages.includes([:user])
      render "chatrooms/show", layout: "chat_layout", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
