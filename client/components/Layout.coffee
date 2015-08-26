component = require 'reactatron/component'
styledComponent = require 'reactatron/styledComponent'
Block     = require 'reactatron/Block'
Box     = require 'reactatron/Box'
Layer     = require 'reactatron/Layer'
Rows      = require 'reactatron/Rows'
Columns   = require 'reactatron/Columns'
Text      = require 'reactatron/Text'
Link      = require 'reactatron/Link'

# Sidebar = require './Sidebar'

module.exports = component 'Layout',

  # getDataBindings: ->
  #   ['horizontalSize']


  render: ->
    console.count('Layout render')

    horizontalSize = @get('horizontalSize')

    navbar = Navbar shrink: 0

    mainContent = MainContent {}, @props.children

    if horizontalSize >= 1
      Layer {},
        Rows grow: 1,
          navbar
          Columns grow: 1, shrink: 1,
            Sidebar {}
            mainContent
    else
      Layer {},
        Rows grow: 1,
          navbar
          Sidebar {}
          mainContent


MainContent = Box.extendStyledComponent 'MainContent',
  flexGrow: 1
  backgroundColor: 'red'
  overflowY: 'auto'


Navbar = component 'Navbar',

  defaultStyle:
    backgroundColor: 'black'
    color: 'white'

  render: ->
    Block @cloneProps(), 'Navbar here'

Sidebar = component 'Sidebar',

  defaultStyle:
    backgroundColor: 'black'
    color: 'white'

  render: ->
    Rows @cloneProps(),
      SidebarLink path: '/transfers', 'Transfers'
      SidebarLink path: '/shows',     'Shows'
      SidebarLink path: '/files',     'Files'
      SidebarLink path: '/bookmarks', 'Bookmarks'


SidebarLink = styledComponent 'SidebarLink', Link,
  backgroundColor: 'orange'
  padding: '0.5em'
  textDecoration: 'none'
  ':hover':
    backgroundColor: 'green'
    color: 'blue'
  ':focus':
    backgroundColor: 'purple'
    color: 'yellow'

