class NewsChannel < ApplicationCable::Channel
  def subscribed
    refresh
    stream_from "news"
  end

  # Послать свежую новость клиенту
  def refresh
    transmit Fetcher.news
  end

  # Послать свежую новость всем клиентам
  def self.refresh
    ActionCable.server.broadcast 'news', Fetcher.news
  end
end
