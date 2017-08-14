require 'test_helper'

class FetcherTest < ActiveSupport::TestCase
  def test_fetch
    assert z = Fetcher.new.fetch
    assert z['date']
    assert z['title']
    assert z['description']
  end

  def test_path
    assert Fetcher.path.directory?
  end

  def test_our_io
    our = {
      title: "Проверка",
      description: "Связи",
      date: Time.now - 1.hour,
      expire: Time.now + 2.hour
    }
    z = Fetcher.new
    z.our = our
    assert_equal our, z.our
  end

  def test_their_io
    their = {
      title: "Мальчик с пальчик",
      description: "Однажды в студёную зимнюю пору...",
      date: Time.now - 2.hour
    }
    z = Fetcher.new
    z.their = their
    assert_equal their, z.their
  end

  def test_override
    our = {'expire' => Time.now + 1.hour}
    their = {'title' => 'Хорошая новость'}
    z = Fetcher.new
    z.our = our
    z.their = their
    assert_equal Fetcher.news, our
    our['expire'] -= 2.hour
    z.our = our
    assert_equal Fetcher.news, their
  end

  def test_expire
    z = Fetcher.new
    z.our = data = {'expire'=> Time.now + 1.hour}
    z.update
    assert_equal z.our, data
    z.our = {'expire'=> Time.now - 1.second}
    z.update
    assert z.our[:expired]
  end

end
