require 'sinatra/base'

module TweetCamp
  class DirectMessagesController < Sinatra::Base
    get '/' do
      if settings.twitter.credentials?
        data = settings.twitter.direct_messages
        erb :direct_message_collection, {locals: {twitter: settings.twitter, dms: data}}
      end
    end
  end
end
