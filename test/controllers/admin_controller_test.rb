require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get data" do
    get admin_data_url
    assert_response :success
  end

end
