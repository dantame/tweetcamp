require 'sinatra/base'
require_relative '../helpers/authentication_helper'

module TweetCamp
  class TimelineController < Sinatra::Base
    helpers TweetCamp::AuthenticationHelper

    get '/?:username?' do
      username = params[:username]
      data = []
      if username
        data = settings.twitter.user_timeline username
      else
        check_authentication
        data = settings.twitter.user_timeline
      end
      erb :tweet_collection, {locals: {twitter: settings.twitter, tweets: data}}
    end
  end
end
