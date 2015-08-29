TransitionGroup = require 'reactatron/TransitionGroup'

component  = require 'reactatron/component'
Space      = require 'reactatron/Space'
Text       = require 'reactatron/Text'
SublteText = require 'reactatron/SublteText'
Columns    = require 'reactatron/Columns'
Rows       = require 'reactatron/Rows'
Box        = require 'reactatron/Box'
Block      = require 'reactatron/Block'
RemainingSpace      = require 'reactatron/RemainingSpace'
Link       = require './Link'
Button     = require './Button'
Icon       = require './Icon'
FileSize   = require './FileSize'

{progress} = require 'reactatron/DOM'


module.exports = component 'TransfersList',

  propTypes:
    transfers: component.PropTypes.any

  # shouldComponentUpdate: (nextProps, nextState) ->
  #   if @props.transfers? && @nextProps.nextProps?

  childFactory: (child) ->
    child
    # TestAnimator {}, child

  renderTransfers: ->
    (@props.transfers || []).map (transfer, index) ->
      Transfer
        stripe: index % 2 == 1
        key: transfer.id
        transfer: transfer

  render: ->
    transfers = @renderTransfers()

    # TransitionGroup
    #   component: Rows,
    #   childFactory: @childFactory
    #   style: width: '100%'
    #   transfers

    Rows
      style: width: '100%'
      transfers

Transfer = component 'Transfer',

  deleteTransfer: ->
    @app.pub 'delete transfer', @props.transfer

  defaultStyle:
    padding: '0.5em 0.5em'
    alignItems: 'center'
    borderTop: '1px solid rgb(235,235,235)'
    ':hover':
      backgroundColor: '#DFEBFF'

  render: ->
    transfer = @props.transfer

    Columns @cloneProps(),
      Rows
        style:
          marginRight: '0.5em'
          flexGrow: 1
          flexShrink: 1
          overflow: 'hidden'
        Columns {},
          Block
            style:
              flexShrink: 1
              overflow: 'hidden'
              textOverflow: 'ellipsis'
              whiteSpace: 'nowrap'

            LinkToTransferFiles(transfer)
          Space()
          LinkToTransferMagnetLink(transfer)
          Space()
          LinkToDownloadTransfer(transfer)
          RemainingSpace {} #style: {flexGrow: 1, flexShrink: 2}
          Space()
          Block style: {width: '3em'},
            FileSize size: transfer.size, style: SublteText.style

        progress
          value: transfer.percent_done
          max: 100
          style:
            width: '100%'
        SublteText
          style:
            overflow: 'hidden'
            textOverflow: 'ellipsis'
            whiteSpace: 'nowrap'
          transfer.status_message
      DeleteTransferButton onConfirmation: @deleteTransfer



DeleteTransferButton = component 'DeleteTransferButton',

  propTypes:
    onConfirmation: component.PropTypes.func.isRequired

  getInitialState: ->
    confirming: false

  confirm: ->
    @setState confirming: true

  reset: ->
    @setState confirming: false

  confirmAndFocus: ->
    @confirm()
    @focus()

  resetAndFocus: ->
    @reset()
    @focus()

  focus: ->
    return if @focusSetTimeout?
    @focusSetTimeout = setTimeout =>
      delete @focusSetTimeout
      (@refs.abort || @refs.trash).getDOMNode().focus()

  scheduleReset: ->
    return if @resetTimeout
    @resetTimeout = setTimeout @reset

  unscheduleReset: ->
    clearTimeout(@resetTimeout) if @resetTimeout?
    delete @resetTimeout

  render: ->
    if @state.confirming
      props = @extendProps
        onFocusOut: @scheduleReset
        onFocusIn: @unscheduleReset
      Columns props,
        Button
          ref: 'confirm'
          onClick: @props.onConfirmation
          style:
            borderTopRightRadius: 0
            borderBottomRightRadius: 0
          Icon glyph: 'check'
        Button
          ref: 'abort',
          onClick: @resetAndFocus,
          style:
            borderLeftWidth: 0
            borderTopLeftRadius: 0
            borderBottomLeftRadius: 0
          Icon glyph: 'times'
    else
      props = @extendProps
        ref: 'trash'
        onClick: @confirmAndFocus
      Button props, Icon(glyph: 'trash-o')



LinkToTransferFiles = (transfer) ->
  Link
    path: "/files/#{transfer.file_id}",
    style:
      textOverflow: 'ellipsis'
      whiteSpace: 'nowrap'
      overflow: 'hidden'
    transfer.name

LinkToTransferMagnetLink = (transfer) ->
  Link href: transfer.magneturi,
    Icon glyph: 'link'

LinkToDownloadTransfer = (transfer) ->
  onClick = (event) ->
    event.preventDefault()
    console.log('would download', transfer)
  Link onClick: onClick, Icon(glyph: 'download')



animator = require '../animator'



# ReactTransitionEvents = require 'react/lib/ReactTransitionEvents'
TestAnimator = component 'TestAnimator',
  componentWillMount: ->
    # console.log('componentWillMount')

  componentDidMount: ->
    # console.log('componentDidMount')

  componentWillUnmount: ->
    # console.log('componentWillUnmount')

  componentWillAppear: (done) ->
    # console.log('componentWillAppear')
    done()

  componentWillEnter: (done) ->
    # console.log('componentWillEnter')
    animator.animate
      target: @getDOMNode()
      name: 'bounceInLeft'
      duration: '500ms'
      done: done

  componentWillLeave: (done) ->
    # console.log('componentWillLeave')
    animator.animate
      target: @getDOMNode()
      name: 'bounceOutLeft'
      duration: '500ms'
      done: done

  render: ->
    @props.children[0]
