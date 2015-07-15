require 'sinatra/base'

module TweetCamp
  class LoginController < Sinatra::Base
    get '/' do
      settings.twitter.callback_host = env['HTTP_HOST']
      erb :index, :locals => {twitter: settings.twitter, tweets: []}
    end

    get '/oauth_callback' do
      verifier = params[:oauth_verifier]
      @access_token = settings.twitter.request_token.get_access_token(:oauth_verifier => verifier)
      settings.twitter.access_token = @access_token.token
      settings.twitter.access_token_secret = @access_token.secret
      redirect '/timeline'
    end
  end
end
