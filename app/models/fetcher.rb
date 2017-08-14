class Fetcher
  URL = 'https://news.yandex.ru/index.rss'
  TICK = 10         # Частота проверок на устаревание
  REFRESH = 60 * 5  # Частота загрузок из Яндекса

  def self.go
    new.go
  end

  def self.path
    z = Rails.root + 'db/data' + Rails.env
    z.mkpath
    z
  end

  # Текущая новость
  def self.news
    new.news
  end

  def path
    self.class.path
  end

  def go
    while true
      update
      sleep TICK
    end
  end

  # Загрузить новость с Яндекса
  def fetch
    require 'openssl/win/root' if Gem.win_platform?
    require 'net/http'
    z = Net::HTTP.get URI URL
    require 'rss'
    z = RSS::Parser.parse(z).items.first
    Hash[%w[date title description].map { |f| [f, z.send(f)] }]
  end

  def load(kind)
    YAML.load_file(path + "#{kind}.yml") rescue {}
  end

  def save(kind, data)
    (path + "#{kind}.yml").write YAML.dump data
  end

  def their
    load :their
  end

  def their=(data)
    save :their, data
  end

  def our
    load :our
  end

  def our=(data)
    save :our, data
  end

  # Играет "наша" новость (игнорируем Яндекс)
  def our?
    our['expire'] > Time.now rescue false
  end

  # Текущая новость
  def news
    our? ? our : their
  end

  # Единичная попытка обновления
  def update
    if our?
      @next = nil
      return
    end

    return if @next && @next > Time.now

    self.our = our.merge expired: Time.now unless @next

    @next = Time.now + REFRESH
    n = fetch rescue {}
    self.their = n if !n.empty? && n != their
  end
end
