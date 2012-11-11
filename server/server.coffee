root = global ? window

Whizmo = Whizmo || {}
root.Whizmo = Whizmo

Buildings = new Meteor.Collection('buildings')

# create some fake data if the db is empty
if not Buildings.find().count()
  Buildings.insert
    "location": "5211 East Kellogg Avenue, Wichita, KS 67218",
    "usage": "Multifamily",
    "opportunity": 367608,
    "benefit": 0,
    "incentives": 6,
    "size": 30000,
    "total_usage_kwh": 568500,
    "benchmark": "Midwest"
  Buildings.insert
    "location": "333 Market Street, San Francisco, CA 94111",
    "usage": "Office",
    "opportunity": 0,
    "benefit": 413512,
    "incentives": 1,
    "size": 80000,
    "total_usage_kwh": 1441600,
    "benchmark": "West"
  Buildings.insert
    "location": "5300 South Howell Avenue, Milwaukee, WI 53207",
    "usage": "Office",
    "opportunity": 514800,
    "benefit": 0,
    "incentives": 1,
    "size": 65000,
    "total_usage_kwh": 1235650,
    "benchmark": "Midwest"
  Buildings.insert
    "location": "1 Wall Street, New York NY 10048",
    "usage": "Office",
    "opportunity": 0,
    "benefit": 4010960,
    "incentives": 1,
    "size": 160000,
    "total_usage_kwh": 2560000,
    "benchmark": "North East"

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
