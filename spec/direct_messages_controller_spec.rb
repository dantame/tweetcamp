require 'controllers/direct_messages_controller'
require 'support/shared_examples/authenticated_message_controller_example'

module TweetCamp
  describe DirectMessagesController do
    include Rack::Test::Methods
    it_behaves_like 'Authenticated Message Controller', :direct_messages
  end
end
