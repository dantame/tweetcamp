require 'sinatra/base'
require_relative '../helpers/authentication_helper'

module TweetCamp
  class DirectMessagesController < Sinatra::Base
    helpers TweetCamp::AuthenticationHelper

    before {
      check_authentication
    }

    get '/' do
      data = settings.twitter.direct_messages
      erb :direct_message_collection, {locals: {twitter: settings.twitter, dms: data}}
    end
  end
end
