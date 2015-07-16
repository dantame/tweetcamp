require 'sinatra/base'

module TweetCamp
  class TimelineController < Sinatra::Base
    get '/?:username?' do
      username = params[:username]
      data = nil
      if username
        data = settings.twitter.user_timeline username
      elsif settings.twitter.credentials?
        data = settings.twitter.user_timeline
      end
      if data
        erb :tweet_collection, {locals: {twitter: settings.twitter, tweets: data}, layout: :index}
      end
    end
  end
end
