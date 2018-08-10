$(document).on 'turbolinks:load', ->
  $('body').on 'click', 'a.remove_user', (e) ->
    $('#remove_user_modal').modal('open')
    $('.remove_user_form').attr('action', 'team_users/' + e.target.id)
    $('#user_remove_id').val(e.target.id)
    return false

  $('.remove_user_form').on 'submit', (e) ->
    $.ajax e.target.action,
      type: 'DELETE',
      dataType: 'json',
      data: { 
        team_id: $('.team_id').val() 
      },
      success: (data, text, jqXHR) ->
        $('.user_' + $('#user_remove_id').val()).remove()
        M.toast({html: 'Succes in remove User &nbsp;<strong>:)</strong>', displayLength: 4000, classes: 'green'})
      error: (jqXHR, textStatus, errorThrown) ->
        M.toast({html: 'Problem to remove User &nbsp;<strong>:(</strong>', displayLength: 4000, classes: 'red'})

    $('#remove_user_modal').modal('close')
    return false