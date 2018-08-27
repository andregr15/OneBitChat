class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    m = message.messageable
    chat_name = "#{m.team_id}_" + (m.class == Channel ? 'channels' : 'talks') + "_#{m.id}"

    avatar = (message.user.avatar.present? == true ? message.user.avatar.thumb.url : nil)

    ActionCable.server.broadcast(
      chat_name,
      {
        message: message.body,
        date: message.created_at.strftime('%d/%m/%y'),
        name: message.user.name,
        avatar: avatar
      }
    )

    ActionCable.server.broadcast(
      'notification_channel',
      {
        type: m.class == Channel ? 'channel' : 'talk',
        id: m.class == Talk ? message.user.id : m.id
      }
    )
  end
end