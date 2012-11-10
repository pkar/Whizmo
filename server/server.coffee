root = global ? window

Whizmo = Whizmo || {}
root.Whizmo = Whizmo || {}

Buildings = new Meteor.Collection('buildings')
Meters = new Meteor.Collection('meters')

Meteor.publish "buildings", () ->
  Meteor.buildings.find({})

Meteor.publish "meters", (id) ->
  #Messages.find({_id: id}, {sort: { time: -1 }})
  Messages.find({_id: id})

Meteor.publish "data", () ->
  [3, 9, 5, 16, 23, 42]

Meteor.startup () ->

Meteor.methods
  filepickerio: () ->
    process.env.FILEPICKERIO
