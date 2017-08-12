$ ->
  do install if $('#main').length

install = ->
  App.news = App.cable.subscriptions.create 'NewsChannel',
    received: (data)->
      $ '#main'
      .html t data

t = withOut ->
  h2 @title
  text 'Дата: ', new Date(@date).toLocaleDateString()
  div -> raw @description
