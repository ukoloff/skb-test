App.news = App.cable.subscriptions.create 'NewsChannel',

  received: (data)->
    console.log "Got", data
