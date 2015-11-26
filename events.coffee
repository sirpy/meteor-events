Events = new Meteor.Collection 'Events'
Events.handlers = {}

mergeNoConflict = (objTo, objFrom) ->
  for k,v of objFrom
    unless objTo[k]? then objTo[k] = v
    else console.warn "Property '#{k}' already exists in object."

runHandler = (name, data...) ->
  handlers = Events.handlers[name]
  if handlers?.length > 0
    (fn data...) for fn in handlers

upsert = (name, data...) ->
  runHandler name, data...
  Events.upsert name:name,
    $set: {data: data, date: new Date,server:!this.connection,client:this.userId},
    (err, args...) ->
      if err? then console.error 'update failed', err
      #else console.log 'updated', (data.concat args)...

Meteor.methods event: upsert

updateEvent = (name, data...) ->
  if Meteor.isClient
    Meteor.call 'event', name, data..., (err, res) ->
      if err? then console.error 'event call failed', err
      #else console.log 'updated', (data.concat args)...
  else upsert name, data...

bind = (name, fn) ->
  handlers = Events.handlers[name]
  if handlers? and fn?
    handlers.push fn
    Events.handlers[name] = handlers
  else if fn? then Events.handlers[name] = [fn]
  else console.error 'fn must be present', fn

if Meteor.isServer
  mergeNoConflict Events,
    on: (name, fn) -> bind name, fn
    emit: (name, data...) ->
      Meteor.publish "events-#{name}", (name) ->
        Events.find name:name
      updateEvent name, data...

else if Meteor.isClient
  subscribeToEvent = (name, fn) ->
    bind name, fn
    Meteor.subscribe "events-#{name}", name

    Events.find(name:name).observe
      changed: (id, event) -> if event? then fn event.data...

  mergeNoConflict Events,
    on: (name, fn) -> subscribeToEvent name, fn
    emit: (name, args...) -> updateEvent name, args...
