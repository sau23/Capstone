require 'test_helper'

class OptionalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @optional = optionals(:one)
  end

  test "should get index" do
    get optionals_url
    assert_response :success
  end

  test "should get new" do
    get new_optional_url
    assert_response :success
  end

  test "should create optional" do
    assert_difference('Optional.count') do
      post optionals_url, params: { optional: { is_gamified: @optional.is_gamified, response: @optional.response, user_id: @optional.user_id } }
    end

    assert_redirected_to optional_url(Optional.last)
  end

  test "should show optional" do
    get optional_url(@optional)
    assert_response :success
  end

  test "should get edit" do
    get edit_optional_url(@optional)
    assert_response :success
  end

  test "should update optional" do
    patch optional_url(@optional), params: { optional: { is_gamified: @optional.is_gamified, response: @optional.response, user_id: @optional.user_id } }
    assert_redirected_to optional_url(@optional)
  end

  test "should destroy optional" do
    assert_difference('Optional.count', -1) do
      delete optional_url(@optional)
    end

    assert_redirected_to optionals_url
  end
end
