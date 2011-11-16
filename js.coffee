$(document).ready ->
  selected_nav = $('#nav_4')
  selected_nav.addClass( 'dwm_nav_sel' )
  sel_fg = sel_bg = unsel_fg = unsel_bg = sel_border = unsel_border = ""
  cw = Raphael.colorwheel($('#color_box')[0], 400, 400 )
  
  $('.dwm_edit_box').click( ->
    owner = $(this)
    cw.color( $(this).css('background-color') )
    cw.onchange( (color) ->
      owner.css('background-color', cw.color().hex )
    )
  )
  
  $('.dwm_nav').click( ->
    selected_nav.removeClass( 'dwm_nav_sel' )
    selected_nav = $(this)
    selected_nav.addClass( 'dwm_nav_sel' )
  )
  return
    
