
# Prevent IE crash if console left in code while debugging.
if _.isUndefined window.console
  window.console =
    log: ->
    debug: ->

# Capture all javascript errors and send to server
window.onerror = (message, file, line) ->
  $.ajax
    url: ''
    cache: false
    data:
      error: "\nFile: #{file}\nLine: #{line}\nError: #{message}"
    complete: (jqXHR, textStatus) ->
    error: (jqXHR, textStatus, errorThrown) ->

$.ajaxSetup
  dataType: 'json'
  type: 'GET'
  cache: false
  global: false
  beforeSend: (jqXHR, settings) ->
  complete: (jqXHR, textStatus) ->
  error: (jqXHR, textStatus, errorThrown) ->
    if errorThrown != 'abort'
      msg = 'Problem communicating with the server'
      if textStatus is 'error'
        msg = "#{jqXHR.responseText.replace(
          '\n', '<br/>').replace('\t', '&nbsp;&nbsp;&nbsp;&nbsp;')}"
      else if textStatus is 'parsererror'
        msg = 'Problem communicating with the server'

      noty
        text: msg
        type: 'error'

$.noty.defaults =
  layout: 'top'
  theme: 'default'
  type: 'alert'
  text: ''
  dismissQueue: true
  template: '<div class="noty_message"><span class="noty_text"></span><div class="noty_close"></div></div>'
  animation:
    open:
      height: 'toggle'
    close:
      height: 'toggle'
    easing: 'swing'
    speed: 500
  timeout: 2000
  force: false
  modal: false
  closeWith: ['click'] # ['click', 'button', 'hover']
  callback:
    onShow: () ->
    afterShow: () ->
    onClose: () ->
    afterClose: () ->
  buttons: false

# Deparam simple hash change values
if _.isUndefined $.deparam
  $.deparam = (params) ->
    pairs = params.split('&')
    obj = {}
    for pair in pairs
      do (pair) ->
        keyval = pair.split('=')
        obj[keyval[0]] = keyval[1]
    return obj

