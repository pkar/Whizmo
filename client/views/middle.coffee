root = global ? window

root.Template.middle.error = ->
  Session.get('error')

root.Template.middle.userName = ->
  user = Meteor.user()
  user?.profile?.name or user?.emails[0]?.address
