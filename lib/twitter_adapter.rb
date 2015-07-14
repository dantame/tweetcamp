require 'twitter'
require 'oauth'
require 'delegate'

module TweetCamp
  class TwitterAdapter < SimpleDelegator

    attr_accessor :callback_host
    attr_reader :request_token
    def initialize twitter_app_key, twitter_app_secret
      @twitter = Twitter::REST::Client.new do |config|
        config.consumer_key = twitter_app_key
        config.consumer_secret = twitter_app_secret
      end
      super(@twitter)
      @callback_host = 'localhost'
      @request_token = nil
    end

    def get_request_token
      @request_token ||= begin
        consumer = OAuth::Consumer.new(@twitter.consumer_key, @twitter.consumer_secret,
                                       { :site => "https://api.twitter.com",
                                         :authorize_path => '/oauth/authenticate',
                                         :sign_in => true })

        consumer.get_request_token({:oauth_callback => "http://#{@callback_host}/login/oauth_callback"})
      end
    end

    def authorize_url
      @authorize_url ||= get_request_token.authorize_url
    end

  end
end
