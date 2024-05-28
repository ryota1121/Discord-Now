require "test_helper"

class Admin::ServersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_servers_index_url
    assert_response :success
  end
end
