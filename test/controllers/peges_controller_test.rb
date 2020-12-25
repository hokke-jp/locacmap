require "test_helper"

class PegesControllerTest < ActionDispatch::IntegrationTest
  test "shoud get root" do
    get root_path
    assert_response :success
    assert_select "title", "Localmap"
  end
end
