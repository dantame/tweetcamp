require_relative 'twitter_adapter'
require 'sinatra/base'
require 'oauth'

module TweetCamp
  # Entry point for tweetcamp app
  class Main < Sinatra::Base
    attr_reader :twitter
    def initialize(twitter_app_key, twitter_app_secret)
      @twitter_app_key = twitter_app_key
      @twitter_app_secret = twitter_app_secret
      @twitter = TwitterAdapter.new do |config|
        config.consumer_key = @twitter_app_key
        config.consumer_secret = @twitter_app_secret
      end
      @request_token = get_request_token(@twitter_app_key,
                                         @twitter_app_secret,
                                         'http://tweet-camp.herokuapp.com/oauth_callback')
      super()
    end

    def get_request_token(consumer_key, consumer_secret, callback_url)
      consumer = OAuth::Consumer.new(consumer_key, consumer_secret,
                                     { :site => "https://api.twitter.com",
                                       :authorize_path => '/oauth/authenticate',
                                       :sign_in => true })
      consumer.get_request_token({:oauth_callback => callback_url})
    end

    get '/' do

    end

    get '/oauth_callback' do
      token = params[:oauth_token]
      verifier = params[:oauth_verifier]
      @access_token = @request_token.get_access_token(:oauth_verifier => verifier)
      @twitter.access_token = @access_token.token
      @twitter.access_token_secret = @access_token.secret
      redirect '/timeline'
    end

    get '/login' do
      erb :login, :locals => {request_token: @request_token}
    end

    get '/timeline/?:username?' do
      username = params[:username]
      if username
        data = @twitter.user_timeline username
      else
        data = @twitter.user_timeline
      end
      erb :timeline, :locals => {tweets: data}
    end
  end
end
