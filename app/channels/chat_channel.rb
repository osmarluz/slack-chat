class ChatChannel < ApplicationCable::Channel
  delegate  :ability, to: :connection
  protected :ability

  def subscribed
    if authorize_and_set_chat
      stream_from "#{params[:team_id]}_#{params[:type]}_#{@chat.id}"
    end
  end

  def receive(data)
    @message = Message.new(body: data["message"], user: current_user)
    @chat.messages << @message
  end

  private

  def authorize_and_set_chat
    if params[:type] == "channels"
      @chat = Channel.find(params[:id])
    elsif params[:type] == "talks"
      @chat = Talk.find_by(user_one_id: [params[:id], current_user.id], user_two_id: [params[:id], current_user.id], team: params[:team_id])
    end
    (ability.can? :read, @chat) ? true : false
  end
end
