module.exports = (app) ->

  app.sub 'find torrent', (event, query) ->


  # app.sub 'reload transfers', ->
  #   app.set "transfers/loading": true

  #   app.putio.transfers().then (transfers) ->
  #     app.set
  #       'transfers/loading': false
  #       transfers: transfers

  # app.sub 'load transfer', (event, transfer_id) ->
  #   console.log('would load transfer', transfer_id)

  # app.sub 'delete transfer', (event, info) ->
  #   return unless info.id?
  #   transfers = app.get 'transfers'
  #   transfers = transfers.filter (transfer) ->
  #     transfer.id != info.id
  #   app.set transfers: transfers




  # app.sub 'download torrent', (event, magnetLink) ->
  #   console.log("%cAdding Magnet Link: #{magnetLink}", 'text-size: 150%; color: red; ')



  # app.sub 'load accountInfo', ->
  #   app.putio.accountInfo().then (accountInfo) ->
  #     app.set 'accountInfo': accountInfo