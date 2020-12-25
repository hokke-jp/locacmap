require "test_helper"

class PegesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get peges_home_url
    assert_response :success
  end
end
