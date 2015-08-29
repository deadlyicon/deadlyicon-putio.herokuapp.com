component = require 'reactatron/component'
Rows = require 'reactatron/Rows'
Box = require 'reactatron/Box'
Block = require 'reactatron/Block'
Layout = require '../components/Layout'
TransfersList = require '../components/TransfersList'
TorrentSeachForm = require '../components/TorrentSeachForm'
SearchForm = require '../components/SearchForm'

module.exports = component 'TransfersPage',

  dataBindings: ->
    transfers: 'transfers'
    loading:   'transfers/loading'

  getInitialState: ->
    filter: ''

  setFilter: (filter) ->
    @setState filter: filter

  componentDidMount: ->
    if !@state.transfers
      @app.pub 'reload transfers'

  render: ->
    Layout null, 'loading...' unless @state.transfers?

    transfers = filter(@state.transfers, @state.filter)
    console.log('RENDER', @state.filter, transfers.length)

    Layout null,
      Rows style: width: '100%',
        FilterForm
          onChange: @setFilter
          style: margin: '0.5em'
        TransfersList transfers: transfers


FilterForm = component 'FilterForm',

  render: ->
    SearchForm
      ref: 'form'
      style:           @props.style
      defaultValue:    @props.defaultValue
      collectionName: 'transfers'
      onChange:        @props.onChange



filter = (transfers, filter) ->
  return transfers if !filter? || filter == ''
  filter = filter.toLowerCase()
  transfers.filter (transfer) ->
    transfer.name.toLowerCase().includes(filter)
