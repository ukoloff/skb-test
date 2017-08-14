require 'test_helper'

class NewsTest < ActionDispatch::IntegrationTest
  def test_index
    get '/'
    assert_response :success
    assert_select '#main', ''
  end

  def test_form
    get '/admin'
    assert_response :success
    assert_select 'form' do
      assert_select 'input'
      assert_select 'textarea'
    end
  end

  def test_post
    start = Time.now
    src = {
      'title' => 'Превед',
      'expire' => start.strftime('%d.%m.%Y'),
      'description' => 'Медвед'
    }
    post '/admin', params: src
    assert_response :redirect
    follow_redirect!
    assert_response :success
    finish = Time.now
    our = Fetcher.new.our
    assert_operator start, :<=, our['date']
    assert_operator finish, :>=, our['date']
    our.delete 'date'
    src['expire'] = start.to_date.to_time
    assert_equal our, src
  end
end
