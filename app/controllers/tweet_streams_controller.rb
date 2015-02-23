class TweetStreamsController < ApplicationController
  attr_accessor :twitter_client
  def new
  end

  def create
    @tweets = twitter_client.user_timeline(params[:twitter_handle])
  end

  def twitter_client
    TWITTER
  end
end
