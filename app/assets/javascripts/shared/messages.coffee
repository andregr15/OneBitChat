set_chat = (name) ->
  $('.chat_name').html(name)

clean_messages = () ->
  $('.messages').html('')
  $('.chat_name').html('')

window.add_message = (message, message_date, name) ->
  $('.messages').append(
    '<div class="message col s12">' +
      '<div class="col m2 l1">' +
        '<i class="material-icons prefix right profile_icon">account_circle</i>' +
      '</div>' +
      '<div class="col m10 s9">' +
        '<div class="row"' +
          '<strong>'+name+'</strong>' +
          '<span class="date">'+message_date+ '</span>' +
        '</div>' +
        '<div class="row">'+message+'</div>' +
      '</div>' +
    '</div>'
  )
  $('.messages').animate({ scrollTop: $('.messages').prop('scrollHeight') }, 100)

window.open = (id, type) ->
  clean_messages()
  if type == 'talks'
    check_user(id)
  else
    set_member_alert(true)

  $.ajax '/' + type + '/' + id,
    type: 'GET',
    contentType: 'application/json',
    dataType: 'json',
    data: {
      team_id: $('.team_id').val()
    },
    success: (data, text, jqXHR) ->
      if type == 'talks'
        set_chat(data['user']['name'])
      else
        set_chat(data['slug'])

      window.change_chat(id, type, $('.team_id').val())

      if data['messages']
        for message in data['messages']
          do ->
            window.add_message(message['body'], message['date'], message['user']['name'])
    error: (jqXHR, textStatus, errorThrown) ->
      M.toast({html: 'Problem to get ' + type + ' informations &nbsp;<strong>:(</strong>', displayLength: 4000, classes: 'red'})
      
  return false

check_user = (id) ->
  $.ajax '/team_users/' + id,
    type: 'GET'
    dataType: 'json',
    data: {
      team_id: $('.team_id').val()
    },
    success: (data, text, jqXHR) ->
      set_member_alert(data)
    error: (jqXHR, textStatus, errorThrown) ->
      M.toast({ html: 'Problem to check if the user still is a member of the team <strong>:(</strong>', displayLength: 4000, classes: 'red' })

  return false

set_member_alert = (data) ->
  if data != true
    $('#message').append('User does not belongs to the team anymore! It\'s no more possible so send messages to him/her.')
    $('#textarea').prop('readonly', true)
  else
    $('#message').html('')
    $('#textarea').prop('readonly', false)

window.add = (slug, id, type) ->
  additional = if type == 'channel' then '#' else ''
  $('.' + type + 's').prepend(
    '<li class="' + type + '_' + id + '">' +
      '<div>' +
        '<a href="#" class="open_' + type + '" id="' + id + '">' +
          '<span id="' + id + '">' + additional + slug + '</span>' +
        '</a>' +
        '<a class="right remove_' + type + '" href="#" id="' + id + '">' +
          '<i class="material-icons" id="' + id + '">settings</i>' +
        '</a>' +
      '</div>' +
    '</li>'
  )