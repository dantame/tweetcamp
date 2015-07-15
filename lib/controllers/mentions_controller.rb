require 'sinatra/base'

module TweetCamp
  class MentionsController < Sinatra::Base
    get '/' do
      if settings.twitter.credentials?
        data = settings.twitter.mentions
        erb :index, :locals => {twitter: settings.twitter, tweets: data}
      else
        redirect '/login'
      end
    end
  end
end
