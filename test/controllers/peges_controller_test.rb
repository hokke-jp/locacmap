require "test_helper"

class PegesControllerTest < ActionDispatch::IntegrationTest
  test "shoud get root" do
    get root_url
    assert_response :success
    assert_select "title", "Home | Localmap"
  end

  test "should get home" do
    get peges_home_url
    assert_response :success
    assert_select "title", "Home | Localmap"
  end
end
