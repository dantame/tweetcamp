require 'controllers/timeline_controller'
require 'support/shared_contexts/controller_context'
require 'support/shared_contexts/tweets_context'

module TweetCamp
  describe TimelineController do
    include Rack::Test::Methods
    include_context 'Controller', TweetCamp::TimelineController
    include_context 'Tweets'
    let (:app) { controller }

    it_behaves_like 'Authenticated Tweet Controller', :user_timeline

    it 'tries to render the template with an array of tweets for a specific username' do
      username = 'dantame'
      expect(controller.twitter).to receive(:user_timeline).with(username).and_return(tweets)

      expect_any_instance_of(described_class)
        .to receive(:erb)
              .with(:tweet_collection,
                    { locals: {
                      twitter: controller.twitter,
                      tweets: tweets
                    },
                      layout: :index }
              )

      get "/#{username}"
      expect(last_response.ok?).to be(true)
    end
  end
end
