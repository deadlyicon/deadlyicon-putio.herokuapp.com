React     = require 'react'
component = require './component'
session   = require './session'
putio     = require './putio'
Path      = require './Path'
Login     = require './components/Login'
Dashboard = require './components/Dashboard'

path = Path(location, history)

{div, span, a, h1} = React.DOM


# TEMP DEBUG
global.DEBUG_PATH = path

getState = ->
  pathname: path.pathname()
  params: path.params()
  put_io_access_token: session('put_io_access_token')

module.exports = component 'App',

  childContextTypes:
    path:   React.PropTypes.object
    putio:  React.PropTypes.any

  putio: ->
    global.putio = if @state.put_io_access_token
      putio(@state.put_io_access_token)
    else
      null

  getChildContext: ->
    path:  path
    putio: @putio()

  getInitialState: ->
    getState()

  onChange: ->
    @setState getState()

  componentDidMount: ->
    session.on('change', @onChange)
    path.on('change', @onChange)

  componentWillUnmount: ->
    session.off('change', @onChange)
    path.off('change', @onChange)

  render: ->
    if @state.put_io_access_token
      Dashboard()
    else
      Login()



module.exports.getTokenFromHash = ->
  if matches = location.hash.match(/^#access_token=(.*)$/)
    path.removeHash()
    session('put_io_access_token', matches[1])
