root = global ? window

root.Template.main.greeting = ->
  #console.log Session.get('user')
  "Hello #{}"

root.Template.main.events =
  "click .filepickerio": (event) ->
    filepicker.pick(
      {mimetypes:['*']},
      #{mimetypes:['image/*']},
      (FPFile) ->
        console.log FPFile
      ,
      (FPError) ->
        console.log FPError
      ,
    )

root.Template.googleAnalytics.code =
  Session.get '_googleAnalytics'

