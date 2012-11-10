root = global ? window

root.Template.center.error = ->
  Session.get('error')

root.Template.center.userName = ->
  user = Meteor.user()
  user?.profile?.name or user?.emails[0]?.address

root.Template.center.data = ->
  [3, 10, 15, 16, 23, 42]

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

class root.Whizmo.AppRouter extends Backbone.Router
  routes:
    "": "index"
    "help": "help"
    "search/:query": "search"
    "*path": "error404"

  initialize: (broker) ->
    @app =
      broker: @broker

  index: ->
    Session.set('content', 'index')

  help: ->
    Session.set('content', 'help')

  search: (query) ->
    Session.set('content', 'search')

  error404: () ->
    document.title = "Error"
    Session.set('content', 'error')


Meteor.startup () ->
  broker = _.extend({}, Backbone.Events)
  appRouter = new root.Whizmo.AppRouter(broker)
  if not Backbone.history.start({pushState: true})
    appRouter.app.middle.$el.html = new root.Whizmo.Views.Error().render().$el

  Meteor.call 'filepickerio', (err, key) ->
    if not err
      filepicker.setKey(key)

