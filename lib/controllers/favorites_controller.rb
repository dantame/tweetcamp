require 'sinatra/base'
require_relative '../helpers/authentication_helper'

module TweetCamp
  class FavoritesController < Sinatra::Base
    register TweetCamp::AuthenticationHelper

    before {
      check_authenticaiton
    }

    get '/' do
      data = settings.twitter.favorites
      erb :tweet_collection, {locals: {twitter: settings.twitter, tweets: data}}
    end
  end
end
