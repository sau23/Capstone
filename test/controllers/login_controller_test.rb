require 'test_helper'

class LoginControllerTest < ActionDispatch::IntegrationTest
  test "should get homepage" do
    get login_homepage_url
    assert_response :success
  end

end
