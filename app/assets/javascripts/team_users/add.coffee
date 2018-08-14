# $(document).on 'turbolinks:load', ->
#   $('.add_user').on 'click', (e) ->
#     $('#add_user_modal').modal('open')
#     $('#team_user_team_id').val(e.target.id)
#     return false

#   $('.add_user_form').on 'submit', (e) ->
#     $.ajax e.target.action,
#       type: 'POST',
#       dataType: 'json',
#       data: {
#         team_user: {
#           email: $('#team_user_email').val(),
#           team_id: $('#team_user_team_id').val()
#         }
#       },
#       success: (data, text, jqXHR) ->
#         window.add(data['user']['name'], data['user']['id'], 'user')
#         M.toast({html: 'Succes in add User &nbsp;<strong>:)</strong>', displayLength: 4000, classes: 'green'})
#       error: (jqXHR, textStatus, errorThrown) ->
#         M.toast({html: 'Problem in add User &nbsp;<strong>:(</strong>', displayLength: 4000, classes: 'red'})

#     $("#add_user_modal").modal('close')
#     return false
