class MessageBroadcastJob < ApplicationJob
  queue_as :default
  
  def perform(message)
    chat = message.messageable
    chat_name = "#{chat.team.id}_#{chat.class.name.downcase}s_#{chat.id}"
    ActionCable.server.broadcast(chat_name, {
                                  message: message.body,
                                  date: message.created_at.strftime("%d/%m/%y"),
                                  name: message.user.name
                                })
  end
end
