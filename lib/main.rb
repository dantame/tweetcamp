require 'twitter'
require 'sinatra/base'

module TweetCamp
  # Entry point for tweetcamp app
  class Main < Sinatra::Base
    attr_reader :twitter
    def initialize(twitter_app_key, twitter_app_secret)
      @twitter = Twitter::REST::Client.new do |config|
        config.consumer_key = twitter_app_key
        config.consumer_secret = twitter_app_secret
      end
    end

    get '/' do
      'Hello World'
    end
  end
end
