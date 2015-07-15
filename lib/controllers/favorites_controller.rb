require 'sinatra/base'

module TweetCamp
  class FavoritesController < Sinatra::Base
    get '/' do
      if settings.twitter.credentials?
        data = settings.twitter.favorites
        erb :index, :locals => {twitter: settings.twitter, tweets: data}
      end
    end
  end
end
