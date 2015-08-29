#= require 'mixins/DepthMixin'

component 'Directory',

  mixins: [DepthMixin]

  propTypes:
    directory: React.PropTypes.object.isRequired

  sessionKey: ->
    "Directory-#{@props.directory.id}-expanded"

  reload: ->
    console.log('reloading', @props.directory.name)
    @forceUpdate()

  componentDidMount: ->
    App.session.on("change:#{@sessionKey()}", @reload)
    App.putio.files.on("change:#{@props.directory.id}", @reload)

  componentWillUnmount: ->
    App.session.removeListener("change:#{@sessionKey()}", @reload)
    App.putio.files.removeListener("change:#{@props.directory.id}", @reload)

  expanded: ->
    App.session(@sessionKey()) || false

  toggle: ->
    App.session(@sessionKey(), !@expanded())

  render: ->
    {div, ActionLink, FileSize} = DOM

    div className: 'File Directory',
      div className: 'File-row flex-row',
        div(style: @depthStyle())
        DOM.Glyphicon
          className: 'Directory-status-icon File-icon',
          glyph: if @expanded() then 'chevron-down' else 'chevron-right'
        ActionLink
          className: 'File-name flex-spacer'
          onClick: @toggle
          @props.directory.name
        div
          className: 'File-size'
          FileSize(size: @props.directory.size)

        DOM.DeleteFileLink file: @props.directory

      if @expanded()
        DOM.DirectoryContents(directory_id: @props.directory.id)

