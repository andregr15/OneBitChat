$(document).on 'turbolinks:load', ->
  M.Modal._count = 0;
  $('.sidenav').sidenav()
  $('.modal').modal()
  $('.dropdown-trigger').dropdown();
  M.updateTextFields();

  $('.collapsible').collapsible();
  
  return false


$(document).on 'ready turbolinks:before-visit', ->
  elem = document.querySelector('#side-bar');
  instance = M.Sidenav.getInstance(elem);
  if instance
    instance.destroy()

  elem = document.querySelector('#side-bar-channel');
  instance = M.Sidenav.getInstance(elem);
  if instance
    instance.destroy()