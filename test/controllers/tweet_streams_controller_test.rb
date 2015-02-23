require "test_helper"

class TweetStreamsControllerTest < ActionController::TestCase
  test "fetches tweets via vcr" do
    VCR.use_cassette("j3_tweets") do
      post :create, :twitter_handle => "j3"
      assert_response :success
      assert_not_nil assigns(:tweets)
      assert_select "li.tweet"
    end
  end
  test "fetches tweets on create" do
    # stub twitter client to modify return of user_timeline
    # method
    # array of "tweet" objects
    # interface: #user -> #screen_name, #text -> "some string"
    # stub("label", :hash => "of", :methods => "to implement")

    fake_client = stub("FakeTwitterClient", user_timeline: tweet_data)
    client = TwitterClient.new(fake_client)
    @controller.twitter_client = client

    post :create, :twitter_handle => "j3"
    assert_response :success
    assert_not_nil assigns(:tweets)
    assert_select "li.tweet"
  end

  def tweet_data
    json = File.read(Rails.root.join("test", "fixtures", "j3_tweets.json"))
    data = JSON.parse(json)
    data.map do |hash|
      Hashie::Mash.new(hash)
    end
  end
end
