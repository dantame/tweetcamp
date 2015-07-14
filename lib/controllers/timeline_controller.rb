require 'sinatra/base'

module TweetCamp
  class TimelineController < Sinatra::Base

    def get_tweets username = nil
      if username
        settings.twitter.user_timeline username
      else
        settings.twitter.user_timeline
      end
    end

    get '/?:username?' do
      username = params[:username]
      data = nil
      if username
        data = get_tweets username
      elsif settings.twitter.credentials?
        data = get_tweets
      end
      if data
        erb :index, :locals => {twitter: settings.twitter, header_links: settings.links, tweets: data}
      else
        redirect '/login'
      end
    end
  end
end
