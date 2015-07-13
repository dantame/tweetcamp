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
      @twitter = TwitterAdapter.new(@twitter_app_key, @twitter_app_secret)
      super()
    end

    get '/' do
      if @twitter.credentials?
        redirect '/timeline'
      else
        redirect '/login'
      end
    end

    get '/oauth_callback' do
      verifier = params[:oauth_verifier]
      @access_token = @twitter.request_token.get_access_token(:oauth_verifier => verifier)
      @twitter.access_token = @access_token.token
      @twitter.access_token_secret = @access_token.secret
      redirect '/timeline'
    end

    get '/login' do
      erb :login, :locals => {request_token: @twitter.request_token}
    end

    get '/timeline/?:username?' do
      username = params[:username]
      data = nil
      if username
        data = @twitter.user_timeline username
      elsif @twitter.credentials?
        data = @twitter.user_timeline
      end
      if data
        erb :tweet_collection, :locals => {tweets: data}
      else
        redirect '/login'
      end

    end

    get '/favorites' do
      if @twitter.credentials?
        data = @twitter.favorites
        erb :tweet_collection, :locals => {tweets: data}
      else
        redirect '/login'
      end
    end

    get '/mentions' do
      if @twitter.credentials?
        data = @twitter.mentions
        erb :tweet_collection, :locals => {tweets: data}
      else
        redirect '/login'
      end
    end
  end
end
