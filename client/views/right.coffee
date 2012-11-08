root = global ? window

Meteor.subscribe("messages")
Meteor.subscribe("rooms")

root.Template.chat.chatError = () ->
  Session.get('chatError')

root.Template.chat.messages = () ->
  room = Session.get('currentRoom')
  if room
    Messages.find({room: room}, {sort: { time: -1 }})

root.Template.rooms.rooms = () ->
  Rooms.find({}, {sort: { name: 1 }})

root.Template.chat.currentRoom = () ->
  Session.get('currentRoom') or null

root.Template.rooms.currentRoom = () ->
  Session.get('currentRoom') or null

root.Template.chat.events =
  "change .chat-room": (event) ->
    Session.set('chatError', null)
    Session.set('currentRoom', event.target.value)

  "click .chat-add-room": (event) ->
    room = root.prompt 'Add room'
    if room
      Rooms.insert
        name: room
        owner: Meteor.userId()

  "click .chat-remove-room": (event) ->
    Rooms.remove
      name: Session.get('currentRoom')
      owner: Meteor.userId()
    Session.set('currentRoom', null)

  "keydown #chat-message": (event) ->
    if event.which is 13
      message = $('#chat-message').val()

      room = Session.get('currentRoom')
      if (not _.isEmpty(message)) and room
        user = Meteor.user()
        userName = user?.profile?.name or user?.emails[0]?.address
        Messages.insert
          name: userName
          message: message
          time: Date.now()
          room: Session.get('currentRoom')

        $('#chat-message').val('')
      else if not room
        Session.set 'chatError', 'Room not set'

