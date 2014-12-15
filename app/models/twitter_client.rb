class TwitterClient
  attr_reader :twitter_client
  def initialize(external_client = TWITTER)
    @twitter_client = external_client
  end

  def fetch_tweets(username)
    twitter_client.user_timeline(username)
  end

  def self.fetch_tweets(username)
    TWITTER.user_timeline(username)
  end
end
