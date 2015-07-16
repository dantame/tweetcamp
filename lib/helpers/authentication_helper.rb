module TweetCamp
  module AuthenticationHelper
    def check_authentication
      halt erb :login, locals: { twitter: settings.twitter } unless settings.twitter.credentials?
    end
  end
end
