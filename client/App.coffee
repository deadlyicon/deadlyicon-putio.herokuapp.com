ReactatronApp = require('reactatron/App')
component = require('reactatron/component')
Putio = require('./Putio')
{div} = require('reactatron/DOM')

App = new ReactatronApp
module.exports = App
App.putio = new Putio(App)

App.Component = component 'App',

  propTypes:
    app: component.PropTypes.instanceOf(ReactatronApp).isRequired

  childContextTypes:
    app: component.PropTypes.object

  getChildContext: ->
    app: @props.app

  getDataBindings: ->
    ['location', 'put_io_access_token']

  render: ->


    {path, params} = @data.location

    Component = switch
      when !@data.put_io_access_token
        require('./pages/LoginPage')

      when path == '/shows'
        require('./pages/ShowsPage')

      when path == '/transfers'
        require('./pages/TransfersPage')

      else
        require('./pages/PageNotFound')

    Component()


App.sub 'reload transfers', ->
  App.putio.transfers().then (transfers) ->
    App.set('transfers', transfers)

App.sub 'load accountInfo', ->
  App.putio.accountInfo().then (accountInfo) ->
    App.set('accountInfo', accountInfo)


# App.router = ->
#   path = @get('path')



#   @match '/',               @redirectTo '/transfers'
#   @match '/shows',          -> require('./pages/ShowsPage')
#   @match '/shows/search',   -> require('./pages/ShowsSearchPage')
#   @match '/shows/:show_id', -> require('./pages/ShowPage')
#   @match '/transfers',      -> require('./pages/TransfersPage')
#   @match '/files',          -> require('./pages/FilesPage')
#   @match '/files/search',   -> require('./pages/FilesSearchPage')
#   @match '/search',         -> require('./pages/TorrentsSearchPage')
#   @match '/autoplay',       -> require('./pages/AutoplayPage')
#   @match '/video/:file_id', -> require('./pages/VideoPage')
#   @match '/*path',          -> require('./pages/PageNotFound')





