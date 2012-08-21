RoomMessages = new Meteor.Collection 'room-messages'

if Meteor.is_client
	Session.set 'activeRoom', 'testing'
	Meteor.autosubscribe ->
		Meteor.subscribe 'room-messages', Session.get 'activeRoom'
	Template.messages.list =
		RoomMessages.find()

if Meteor.is_server
	Meteor.methods
		'test' : (room) ->
			RoomMessages.findOne
				room : room
		'room message' : (message, room) ->
			RoomMessages.insert
				user     : this.userId()
				room     : room
				message  : message
				created  : new Date()

	Meteor.publish 'room-messages', (room) ->
		console.log(room)
		RoomMessages.find
			room : room