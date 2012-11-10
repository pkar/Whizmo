root = global ? window

Whizmo = Whizmo || {}
root.Whizmo = Whizmo || {}

root.Template.main.error = ->
  Session.get('error')

root.Template.main.userName = ->
  user = Meteor.user()
  user?.profile?.name or user?.emails[0]?.address

root.Template.main.data = ->
  [3, 9, 5, 16, 23, 42]

root.Template.main.content = ->
  Session.get('content')

root.Template.main.events =
  "click .blah": (event) ->
    console.log event

class root.Whizmo.AppRouter extends Backbone.Router
  routes:
    "": "index"
    "buildings": "buildings"
    "meters": "meters"
    "help": "help"
    "search/:query": "search"
    "*path": "error404"

  initialize: (broker) ->
    @app =
      broker: @broker

  buildings: ->
    Session.set('content', 'buildings')

  meters: ->
    Session.set('content', 'meters')

  index: ->
    Session.set('content', 'index')

  help: ->
    Session.set('content', 'help')

  error404: () ->
    document.title = "Error"
    Session.set('content', 'error')


Meteor.startup () ->
  broker = _.extend({}, Backbone.Events)
  appRouter = new root.Whizmo.AppRouter(broker)
  if not Backbone.history.start({pushState: false})
    appRouter.app.middle.$el.html = new root.Whizmo.Views.Error().render().$el

