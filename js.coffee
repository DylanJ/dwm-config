vars = new Array()
owner = ""

bg = (selector, color) ->
  $(selector).css('background-color', color )

fg = (selector, color) ->
  $(selector).css('color', color )

init = ->
  for sel of vars
    do (sel) ->
      bg('#'+sel, vars[sel] )
      $('#'+sel).text( vars[sel] )
      return
    
  #bg( '#sel_bg', vars['sel_bg'] )
  #$( '#sel_bg' )[0].textContent = vars['sel_bg']
  draw()
  $( '#color_box' ).hide()
  return

write_colors = ->
  $('#output').text(
    'static const char normbordercolor[] = "' + vars['unsel_border'] + '";\n' +
    'static const char normbgcolor[]     = "' + vars['unsel_bg'] + '";\n' +
    'static const char normfgcolor[]     = "' + vars['unsel_fg'] + '";\n' +
    'static const char selbordercolor[]  = "' + vars['sel_border'] + '";\n' +
    'static const char selbgcolor[]      = "' + vars['sel_bg'] + '";\n' +
    'static const char selfgcolor[]      = "' + vars['sel_fg'] + '";'
  )

draw = ->
  # unselected workspace name
  fg( '.dwm_nav', vars['unsel_fg'] )
  bg( '.dwm_nav', vars['unsel_bg'] )
  
  # selected workspace name
  fg( '.dwm_nav_sel', vars['sel_fg'] )
  bg( '.dwm_nav_sel', vars['sel_bg'] )
  
  # background behind workspace names
  bg( '.dwm_nav_bar', vars['unsel_bg'] )
  
  # background for the rest of the bar
  bg( '.dwm_wrap', vars['sel_bg'] )
  fg( '.dwm_bar', vars['sel_fg'] )
  bg( '.dwm_bar', vars['sel_bg'] )

  # window title
  fg( '.dwm_title', vars['sel_fg'] )
  bg( '.dwm_title', vars['sel_bg'] )

  # root info
  fg( '.dwm_root', vars['unsel_fg'] )
  bg( '.dwm_root', vars['unsel_bg'] )
  
  $('#output').css('border', 'solid 5px ' + vars['unsel_border'])

  write_colors()
  return

$(document).ready ->
  selected_item = ""
  selected_nav = $('#nav_4')
  selected_nav.addClass( 'dwm_nav_sel' )
  
  vars['sel_fg'] = '#000000'
  vars['sel_bg'] = '#1b7ee0'
  vars['unsel_fg'] = '#ffffff'
  vars['unsel_bg'] = '#393939'
  vars['sel_border'] = '#aaaaaa'
  vars['unsel_border'] = '#0d0d0d'

  init()
  
  cw = Raphael.colorwheel($('#color_box')[0], 300, 300 )
  cw.color( $('#sel_fg').css('background-color') )
  
  $('#output').hover(
    -> $(this).css('border', 'solid 5px ' + vars['sel_border'] ),
    -> $(this).css('border', 'solid 5px ' + vars['unsel_border'] )
  )

  $('.dwm_edit_box').click( ->
    
    $('#color_box').show()
    if ( owner )
      owner.css('border-left', 'solid 0px #ffffff' )
    
    owner = $(this)
    owner.css( 'border-left', 'solid 5px #ffffff' )
    selected_item = this.id
    cw.color( $(this).css('background-color') )
    cw.onchange( (color) ->
      owner.css('background-color', cw.color().hex )
      owner[0].textContent = cw.color().hex
      vars[selected_item] = cw.color().hex
      draw()
      return
    )
    return
  )
  
  $('.dwm_nav').click( ->
    selected_nav.removeClass( 'dwm_nav_sel' )
    selected_nav = $(this)
    selected_nav.addClass( 'dwm_nav_sel' )
    draw()
  )
  return
    
