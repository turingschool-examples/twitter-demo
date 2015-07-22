require "test_helper"

class TweetStreamsControllerTest < ActionController::TestCase
  test "fetches tweets on create" do
    @controller.twitter_client.
      expects(:user).
      with("j3").
      returns(Hashie::Mash.new({followers_count: 50}))
    post :create, :twitter_handle => "j3"
    assert_response :success
    assert_not_nil assigns(:tweets)
    assert_select "li.tweet"
  end

  test "fetches tweets with prod data" do
    @controller.twitter_client.expects(:user_timeline).with("j3").returns(tweet_data)
    post :create, :twitter_handle => "j3"
    assert_response :success
    assert_not_nil assigns(:tweets)
    assert_select "li.tweet"
  end

  def tweet_data
    JSON.parse(File.read(File.join(Rails.root, "test", "fixtures", "tweets_response.json"))).map do |hash|
      Hashie::Mash.new(hash)
    end
  end
end
