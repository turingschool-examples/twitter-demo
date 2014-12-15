require "test_helper"
require "ostruct"

class TweetStreamsControllerTest < ActionController::TestCase
  test "fetches tweets on create" do
    tweet = OpenStruct.new(:text => "turing is gr8 xoxo",
                           :user => OpenStruct.new(:screen_name => "j3"))
    TWITTER.expects(:user_timeline).with("j3").returns([tweet])

    post :create, :twitter_handle => "j3"
    assert_response :success
    assert_not_nil assigns(:tweets)
    assert_select "li.tweet"
  end

  test "fetches tweets with our own client" do
    skip
    tweet = OpenStruct.new(:text => "turing is gr8 xoxo",
                           :user => OpenStruct.new(:screen_name => "j3"))

    TwitterClient.expects(:fetch_tweets).with("j3").returns([tweet])

    post :create, :twitter_handle => "j3"
    assert_response :success
    assert_not_nil assigns(:tweets)
    assert_select "li.tweet"
  end

  test "fetches tweets with mocked client" do
    test_client = TwitterClient.new(MockClient.new)
    @controller.twitter_client = test_client
    post :create, :twitter_handle => "j3"
    assert_response :success
    assert_not_nil assigns(:tweets)
    assert_select "li.tweet"
  end
end

class MockClient
  def user_timeline(username)
    [OpenStruct.new(:text => "turing is gr8 xoxo",
                    :user => OpenStruct.new(:screen_name => "j3"))]
  end
end
