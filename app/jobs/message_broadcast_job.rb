class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    m = message.messageable
    chat_name = "#{m.team_id}_" + (m.class == Channel ? 'channels' : 'talks') + "_#{m.id}"

    ActionCable.server.broadcast(
      chat_name,
      {
        message: message.body,
        date: message.created_at.strftime('%d/%m/%y'),
        name: message.user.name
      }
    )
  end
end