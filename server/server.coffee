
Meteor.publish "directory", () ->
  Meteor.users.find({}, {fields: {emails: 1, profile: 1}})

Meteor.startup () ->

Meteor.publish "messages", () ->
  Messages.find({}, {sort: { time: -1 }})

Meteor.publish "rooms", () ->
  Rooms.find({}, {sort: { name: -1 }})

Meteor.methods
  filepickerio: () ->
    process.env.FILEPICKERIO
  googleAnalytics: () ->
    process.env.GOOGLE_ANALYTICS

Messages.allow
  insert: (userId, message) ->
    count = Messages.find({}).count()
    if count > 10
      last = Messages.find({}, {sort: { time: 1 }, limit: 1})
      last.forEach (e) ->
        Messages.remove
          _id: e._id
          time: e.time
    true
  update: (userId, message, fields, modifier) ->
    false
  remove: (userId, message) ->
    false

Rooms.allow
  insert: (userId, room) ->
    count = Rooms.find({}).count()
    if count > 50
      last = Rooms.find({}, {sort: { time: 1 }, limit: 1})
      last.forEach (e) ->
        Rooms.remove
          _id: e._id
    true
  update: (userId, room, fields, modifier) ->
    false
  remove: (userId, rooms) ->
    _.any rooms, (room) ->
      room.owner is userId
