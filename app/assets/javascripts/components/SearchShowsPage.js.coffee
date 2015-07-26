#= require 'ReactPromptMixin'

component 'SearchShowsPage',

  mixins: [ReactPromptMixin]

  contextTypes:
    params: React.PropTypes.object.isRequired

  render: ->
    DOM.div
      className: 'SearchShowsPage'
      DOM.ShowSearchForm()
      DOM.ShowSearchResults(query: @context.params.s)
