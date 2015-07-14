require 'controllers/timeline_controller'
require 'support/shared_contexts/controller_context'
require 'support/shared_contexts/tweets_context'

module TweetCamp
  describe TimelineController do
    include Rack::Test::Methods
    include_context 'Controller', TweetCamp::TimelineController
    include_context 'Tweets'
    let (:app) { controller }

    it 'tries to render the template with an array of tweets' do
      expect(controller.twitter).to receive(:user_timeline).and_return(tweets)

      expect_any_instance_of(described_class)
        .to receive(:erb)
              .with(:index,
                    :locals => {
                            twitter: controller.twitter,
                            header_links: controller.links,
                            tweets: tweets
                          }
              )

      get '/timeline'
      expect(last_response.ok?).to be(true)
    end
  end
end
