$ ->
  do install if $('#main').length

install = ->
  App.news = App.cable.subscriptions.create 'NewsChannel',
    received: (data)->
      $ '#main'
      .html t data

t = withOut ->
  h1 @title, ' ', -> small @ruda
  div -> raw @description
