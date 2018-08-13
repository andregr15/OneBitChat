$(document).on 'turbolinks:load', ->
  $('body').on 'click', 'a.leave_team', (e) ->
    $('#leave_team_modal').modal('open')
    $('.leave_team_form').attr('action', 'team_users/' + e.target.id)
    $('#leave_team_id').val(e.target.id)
    console.log(e.target.id)
    return false

  $('.leave_team_form').on 'submit', (e) ->
    $.ajax e.target.action,
      type: 'DELETE',
      dataType: 'json',
      data: { 
        team_id: $('.team_id').val() 
      },
      success: (data, text, jqXHR) ->
        $(location).attr('href', '/')
      error: (jqXHR, textStatus, errorThrown) ->
        M.toast({html: 'Problem to leave Team &nbsp;<strong>:(</strong>', displayLength: 4000, classes: 'red'})

    $('#leave_team_modal').modal('close')
    return false