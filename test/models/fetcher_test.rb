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
end
