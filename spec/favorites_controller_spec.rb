require 'controllers/favorites_controller'
require 'support/shared_examples/authenticated_tweet_controller_example'

module TweetCamp
  describe FavoritesController do
    include Rack::Test::Methods
    it_behaves_like 'Authenticated Tweet Controller', :favorites
  end
end
