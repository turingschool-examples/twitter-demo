class TweetStreamsController < ApplicationController
  attr_accessor :twitter_client
  def new
  end

  def create
    @tweets = twitter_client.fetch_tweets(params[:twitter_handle])
  end

  def twitter_client
    @twitter_client ||= twitter_client.new
  end
end
