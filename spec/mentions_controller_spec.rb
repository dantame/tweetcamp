require 'controllers/mentions_controller'
require 'support/shared_contexts/controller_context'
require 'support/shared_contexts/tweets_context'

module TweetCamp
  describe MentionsController do
    include Rack::Test::Methods
    include_context 'Controller', TweetCamp::MentionsController
    include_context 'Tweets'
    let (:app) { controller }

    it 'tries to render the template with an array of tweets' do
      expect(controller.twitter).to receive(:mentions).and_return(tweets)
      expect(controller.twitter).to receive(:credentials?).and_return(true)

      expect_any_instance_of(described_class)
        .to receive(:erb)
              .with(:index,
                    :locals => {
                      twitter: controller.twitter,
                      tweets: tweets
                    }
              )

      get '/'
      expect(last_response.ok?).to be(true)
    end

    it 'redirects to login if the user is not authenticated and the root path is requested' do
      allow(controller.twitter).to receive(:credentials?).and_return(false)
      allow(controller.twitter).to receive(:user_timeline)

      get '/'
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.url).to include('/login')
    end
  end
end
