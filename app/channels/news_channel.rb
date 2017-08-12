class NewsChannel < ApplicationCable::Channel
  def subscribed
    refresh
    stream_from "news"
    self.class.listen
  end

  def self.news
    z = Fetcher.news
    z['ruda'] = z['date'].strftime '%d.%m.%Y %H:%M'
    z
  end

  # Послать свежую новость клиенту
  def refresh
    transmit self.class.news
  end

  # Послать свежую новость всем клиентам
  def self.refresh
    ActionCable.server.broadcast 'news', news
  end

  # Слушать изменения в папке
  def self.listen
    return if @listen
    @listen = Listen.to(Fetcher.path){ refresh }
    @listen.start
  end

end
