require 'twitter'
require 'oauth'
require 'delegate'

module TweetCamp
  class TwitterAdapter < SimpleDelegator

    attr_reader :request_token
    def initialize twitter_app_key, twitter_app_secret
      @twitter = Twitter::REST::Client.new do |config|
        config.consumer_key = twitter_app_key
        config.consumer_secret = twitter_app_secret
      end
      super(@twitter)
      @request_token = get_request_token(twitter_app_key,
                                         twitter_app_secret,
                                         'http://127.0.0.1:9292/login/oauth_callback')
    end

    def get_request_token(consumer_key, consumer_secret, callback_url)
      consumer = OAuth::Consumer.new(consumer_key, consumer_secret,
                                     { :site => "https://api.twitter.com",
                                       :authorize_path => '/oauth/authenticate',
                                       :sign_in => true })
      consumer.get_request_token({:oauth_callback => callback_url})
    end

  end
end
