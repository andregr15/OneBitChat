App.notification = App.cable.subscriptions.create "NotificationChannel",
  received: (data) ->
    window.set_notification(data.type, data.id)
    # alert data.id + ' ' + data.type
    # Called when there's incoming data on the websocket for this channel
