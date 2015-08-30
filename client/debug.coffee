window.DEBUG = DEBUG = {};


DEBUG.React = require 'react/addons'
DEBUG.URI = require 'URIjs'
DEBUG.ReactElement = require 'react/lib/ReactElement'
app = require './app'
DEBUG.app = app
DEBUG.animator = require './animator'
DEBUG.Style = require 'reactatron/Style'

DEBUG.app.sub '*', (event, payload) ->
  console.log('Event', event, payload)

# DEBUG.app.sub 'store:change:location', ->
#   console.info('Location change', app.get('location'))



# app.sub 'store:change:horizontalSize', ->
#   console.info('horizontalSize', app.get('horizontalSize'))

# console.info('horizontalSize', app.get('horizontalSize'))


DEBUG.app.pub('DEBUG:here')


DEBUG.Box = require 'reactatron/Box'
DEBUG.Block = require 'reactatron/Block'
DEBUG.Rows = require 'reactatron/Rows'


global.log = console.log.bind(console)

global.clearLocalStorage = ->
  delete localStorage[key] for key of localStorage


global.reset = ->
  clearLocalStorage()
  location.reload()


# window.addEventListener "beforeunload", (event) ->
#   event.returnValue = "Should this have been a page unload?"
