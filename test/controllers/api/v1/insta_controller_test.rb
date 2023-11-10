require "test_helper"

class Api::V1::InstaControllerTest < ActionDispatch::IntegrationTest
  test "should get confirm" do
    get api_v1_insta_confirm_url
    assert_response :success
  end

  test "should get notice" do
    get api_v1_insta_notice_url
    assert_response :success
  end
end
