require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
  Path = '/admin'
  def test_show
    get Path
    assert_response :success
  end

  def test_create
    post Path
    assert_response :success

    post Path, params: {
      title: 'Hello',
      description: 'Word',
      expire: (Time.now + 1.day).strftime('%d.%m.%Y')
    }
    assert_response :redirect
  end
end
