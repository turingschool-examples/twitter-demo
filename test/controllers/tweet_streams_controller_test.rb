require "test_helper"

class TweetStreamsControllerTest < ActionController::TestCase
  test "fetches tweets on create" do
    # stub twitter client to modify return of user_timeline
    # method
    # array of "tweet" objects
    # interface: #user -> #screen_name, #text -> "some string"
    # stub("label", :hash => "of", :methods => "to implement")
    @controller.twitter_client
      .expects(:user_timeline)
      .with("j3")
      .returns([stub("Tweet", message: "heres a AALLL CAPS tweet", user: stub(screen_name: "j3"))])
    post :create, :twitter_handle => "j3"
    assert_response :success
    assert_not_nil assigns(:tweets)
    assert_select "li.tweet"
  end
end
