require 'test_helper'

class PosterTest < ActiveSupport::TestCase
  Good = {
    title: 'A',
    description: 'B',
    expire: Time.now.strftime('%d.%m.%Y')
  }
  def test_ok
    z = Poster.new Good
    assert z.our
    assert_not z.errors
  end

  def test_fail
    Good.each do |k,v|
      z = Good.dup
      z.delete k
      z = Poster.new z
      assert z.our
      assert z.errors
    end
  end
end
