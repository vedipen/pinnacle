require 'test_helper'

class HiddenleaderboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hiddenleaderboard_index_url
    assert_response :success
  end

end
