require 'controllers/mentions_controller'
require 'support/shared_examples/authenticated_tweet_controller_example'

module TweetCamp
  describe MentionsController do
    include Rack::Test::Methods
    it_behaves_like 'Authenticated Tweet Controller', :mentions
  end
end
