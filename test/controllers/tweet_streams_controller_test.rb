require "test_helper"
require "hashie"

class TweetStreamsControllerTest < ActionController::TestCase
  def tweet_data
    raw_json = File.read(Rails.root.join("test", "fixtures", "tweets.json"))
    data = JSON.parse(raw_json)
    data.map do |hash|
      Hashie::Mash.new(hash)
    end
  end

  test "shows tweet data for worace" do
    VCR.use_cassette("worace_user_timeline") do
      post :create, twitter_handle: "worace"
    end

    #assertions....

  end

  test "shows tweet data using VCR" do
    VCR.use_cassette("j3_user_timeline") do
      post :create, twitter_handle: "j3"
    end

    assert_response :success
    assert_not_nil assigns(:tweets)
    assert_select "li.tweet"
    assert_select "h5",
                    count: 1,
                    text: "(j3 has 5801 followers)"
  end

  test "shows user tweets using static production fixtures" do
    user = stub("j3 twitter user", followers_count: 5802)
    @controller.twitter_client.expects(:user).with("j3").returns(user)

    @controller.twitter_client.
      expects(:user_timeline).
      with("j3").
      returns(tweet_data)

    post :create, twitter_handle: "j3"

    assert_response :success
    assert_not_nil assigns(:tweets)
    assert_select "li.tweet", count: tweet_data.count
    assert_select "h5",
                    count: 1,
                    text: "(j3 has 5802 followers)"
  end

  test "shows some twitter data for the user" do
    tweet = stub("a tweet", text: "ALL CAPS BRO",
                            user: stub("A user", screen_name: "j3"))

    @controller.
      twitter_client.
      expects(:user_timeline).
      with("j3").
      returns([tweet])

    user = stub("j3 twitter user", followers_count: 5802)
    @controller.
      twitter_client.
      expects(:user).
      with("j3").
      returns(user)

    post :create, twitter_handle: "j3"
    assert_response :success
    assert_not_nil assigns(:tweets)
    assert_select "li.tweet"
    assert_select "h5",
                    count: 1,
                    text: /j3 has \d+ followers/
  end
end
