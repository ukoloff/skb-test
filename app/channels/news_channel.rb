class NewsChannel < ApplicationCable::Channel
  def subscribed
    refresh
    stream_from "news"
    self.class.listen
  end

  # Послать свежую новость клиенту
  def refresh
    transmit Fetcher.news
  end

  # Послать свежую новость всем клиентам
  def self.refresh
    ActionCable.server.broadcast 'news', Fetcher.news
  end

  # Слушать изменения в папке
  def self.listen
    return if @listen
    @listen = Listen.to(Fetcher.path){ refresh }
    @listen.start
  end

end
