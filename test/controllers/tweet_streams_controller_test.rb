require "test_helper"

class TweetStreamsControllerTest < ActionController::TestCase
  test "fetches tweets on create" do
    post :create, :twitter_handle => "j3"
    assert_response :success
    assert_not_nil assigns(:tweets)
    assert_select "li.tweet"
  end
end
