require 'test_helper'

class SurveyControllerTest < ActionDispatch::IntegrationTest
  test "should get instructions" do
    get survey_instructions_url
    assert_response :success
  end

  test "should get question" do
    get survey_question_url
    assert_response :success
  end

  test "should get feedback" do
    get survey_feedback_url
    assert_response :success
  end

end
