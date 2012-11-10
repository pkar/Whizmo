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

root.Template.main.brag = ->
  [
    "My buildings have improved 85% over the past 3 weeks.",
    "My office building at 1 Carrot Way, Anytown USA is performing 23% better than industry average.",
    "Recent investments have improved 3 of my buildings by over $0.53 per square foot."
  ]

root.Template.main.building = ->
  [
    {
        "location":"1 Carrot Way, Yourtown, USA",
        "usage":"Office",
        "opportunity":"$5000",
        "incentives":6
    },
    {
        "location":"500 Main Street, Fancypants, CA",
        "usage":"Office",
        "opportunity":"$7500",
        "incentives":1
    }
  ]

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
    "add": "add"
    "edit": "edit"
    "help": "help"
    "search/:query": "search"
    "*path": "error404"

  initialize: (broker) ->
    @app =
      broker: @broker

  edit: ->
    Session.set('content', {type: {edit: true}})

  add: ->
    Session.set('content', {type: {add: true}})

  buildings: ->
    Session.set('content', {type: {buildings: true}})

  meters: ->
    Session.set('content', {type: {meters: true}})

  index: ->
    Session.set('content', {type: {index: true}})

  help: ->
    Session.set('content', {type: {help: true}})

  error404: () ->
    document.title = "Error"
    Session.set('content', 'error')


Meteor.startup () ->
  broker = _.extend({}, Backbone.Events)
  appRouter = new root.Whizmo.AppRouter(broker)
  if not Backbone.history.start({pushState: false})
    appRouter.app.middle.$el.html = new root.Whizmo.Views.Error().render().$el

