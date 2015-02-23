class TwitterClient # <--- ours (we control it)
  attr_reader :client
  def initialize(client = TWITTER)
    @client = client
  end

  # @client reqs - client is a dependency
  # user_timeline
  #   -> Array of:
  #     -> "Tweet"-things
  #       -> text -> String
  #       -> user -> "User"-thing
  #                 -> screen_name
  def fetch_tweets(twitter_handle)
    client.user_timeline(twitter_handle)
  end

  def self.fetch_tweets(twitter_handle)
    TWITTER.user_timeline(twitter_handle) # <-- theirs - we have no control
  end
end
