require "test_helper"

class TweetStreamsControllerTest < ActionController::TestCase
  test "fetches user tweets on #create" do
    jeff = stub(followers_count: 0)
    @controller.twitter_client.expects(:user).returns(jeff)

    tweets = [stub(text: "hi", user: stub(screen_name: "pizza man"),
                   loves_pizza: true)]
    @controller.twitter_client.stubs(:user_timeline).returns(tweets)

    post :create, twitter_handle: "j3"
    assert_response :success
    assert_not_nil assigns(:tweets)
    assert_select "li.tweet"
  end

  test "stubs request using real production data" do
    @controller.twitter_client.stubs(user_timeline: tweet_data)
    @controller.twitter_client.stubs(user: user_data)
    post :create, twitter_handle: "j3"
    assert_response :success
    assert_not_nil assigns(:tweets)
    assert_select "li.tweet"
  end

  test "stubs request using VCR" do
    VCR.use_cassette("j3_data") do
      post :create, twitter_handle: "j3"
      assert_response :success
      assert_not_nil assigns(:tweets)
      assert_select "li.tweet"
    end
  end

  test "requesting worace" do
    VCR.use_cassette("worace_data") do
      Faraday.get("http://google.com")
      @controller.twitter_client.user("worace")
    end
  end

  def tweet_data
    JSON.parse(File.read(File.join(Rails.root, "test", "fixtures", "sample_response.json"))).map do |hash|
      Hashie::Mash.new(hash)
    end
  end

  def user_data
    path = File.join(Rails.root, "test", "fixtures", "user_data.json")
    json = JSON.parse(File.read(path))
    Hashie::Mash.new(json)
  end
end
