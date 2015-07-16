require 'sinatra/base'

module TweetCamp
  class FavoritesController < Sinatra::Base
    get '/' do
      if settings.twitter.credentials?
        data = settings.twitter.favorites
        erb :tweet_collection, {locals: {twitter: settings.twitter, tweets: data}, layout: :index}
      end
    end
  end
end