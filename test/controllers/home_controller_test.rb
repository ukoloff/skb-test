require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  def test_index
    get '/'
    assert_response :success
  end
end
