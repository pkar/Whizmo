root = global ? window

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

  Meteor.call 'googleAnalytics', (err, key) ->
    if err
      console.log err
    Session.set '_googleAnalytics', key

