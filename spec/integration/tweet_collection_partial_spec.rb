require 'support/page_objects/tweet_collection_page'
require 'controllers/timeline_controller'
require 'support/shared_contexts/controller_context'
require 'support/shared_contexts/tweets_context'
require 'support/shared_contexts/page_context'
require 'support/shared_examples/tweet_collection_example'

module TweetCamp
  describe TweetCollectionPage, :type => :feature do
    include_context 'Controller', TweetCamp::TimelineController
    include_context 'Tweets'
    include_context 'Page'
    let (:authenticated) { true }
    let (:request_token) { double() }

    before :each do
      allow(controller.twitter).to receive(:authorize_url).and_return('test')
      allow(controller.twitter).to receive(:user_timeline).and_return(tweets)
      allow(controller.twitter).to receive(:credentials?).and_return(authenticated)
    end

    context '/' do
      context 'user is authenticated' do
        it_behaves_like 'Tweet Collection'
      end
    end

    context '/?:username?' do
      context 'user is authenticated' do
        it_behaves_like 'Tweet Collection' do
          let(:username) { 'dantame' }
        end
      end

      context 'user is not authenticated' do
        let (:authenticated) { false }
        it_behaves_like 'Tweet Collection' do
          let(:username) { 'dantame' }
        end
      end
    end
  end
end
