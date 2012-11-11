require = __meteor_bootstrap__.require
fs = require 'fs'
root = global ? window

Whizmo = Whizmo || {}
root.Whizmo = Whizmo

Buildings = new Meteor.Collection('buildings')
Benchmarks = new Meteor.Collection('benchmarks')
Meters = new Meteor.Collection('meters')

read_fixture = (name) ->
  data = fs.readFileSync './data/' + name + '.json', 'utf8'
  JSON.parse(data)

load_fixture = (name, model, clean=true) ->
  if clean
    model.remove {}

  # only load fixtures if we don't already have data
  if model.find().count()
    return

  for data in read_fixture name
    model.insert data

load_fixture('mock/buildings', Buildings)
load_fixture('mock/benchmarks', Benchmarks)

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
