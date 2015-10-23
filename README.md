# meteor-events
Client &amp; Server Reactive Events for Meteor

# Overview
Meteor events can be bound on client, server, or both the same way.
Meteor events can be emitted from client and server, and will broadcast to the server (if it is listening) as well as all clients.

You can use this to have a consistent way of doing simple meteor methods, or to have events synchronized across clients and the server.

# Examples
```
// Binding events

Events.on('printSomething', function (something, data) {
    console.log(something, data)
})

if (Meteor.isClient /* can also be in a client directory */) {
    Events.on('doSomethingOnAllClients', function (data) {
        doSomething(data)
    })
}

if (Meteor.isServer /* can also be in a server directory */) {
    Events.on('doSomethingOnTheServer', function (data) {
        doSomething(data)
    })
}


// Emitting events

// Sends this event to all clients and the server
Events.emit('printSomething', 'Some awesome text', myVar)

if (Meteor.isClient /* can also be in a client directory */)
    Events.emit('doSomethingOnAllClients', {name: 'Bob', age: 83})

if (Meteor.isServer /* can also be in a server directory */)
    Events.emit('doSomethingOnTheServer', {name: 'Bob', age: 83})
```
