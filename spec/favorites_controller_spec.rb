require 'controllers/favorites_controller'
require 'support/shared_examples/authenticated_controller_example'

module TweetCamp
  describe FavoritesController do
    include Rack::Test::Methods
    it_behaves_like 'Authenticated Controller', :favorites
  end
end
