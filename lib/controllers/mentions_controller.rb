require 'sinatra/base'
require_relative '../helpers/authentication_helper'

module TweetCamp
  class MentionsController < Sinatra::Base
    helpers TweetCamp::AuthenticationHelper

    before {
      check_authentication
    }

    get '/' do
      data = settings.twitter.mentions
      erb :tweet_collection, {locals: {twitter: settings.twitter, tweets: data}}
    end
  end
end
