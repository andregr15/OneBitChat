window.change_chat = (id, type, team_id) ->
  if App.chat != undefined
    obj = JSON.parse(App.chat.identifier)
    if obj.type == type && obj.id == id && obj.team_id == team_id
      return

    App.chat.unsubscribe()

  App.chat = App.cable.subscriptions.create { channel: 'ChatChannel', id: id, type: type, team_id: team_id },
    received: (data) ->
      window.add_message(data.message, data.date, data.name, data.avatar)