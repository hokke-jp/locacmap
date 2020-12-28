require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'peges/home'
    assert_select "a[href=?]", root_path
  end
end
