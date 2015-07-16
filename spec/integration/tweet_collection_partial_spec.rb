require 'controllers/timeline_controller'

module TweetCamp
  describe TweetCollectionPage, :type => :feature do
    include_context 'Controller', TweetCamp::TimelineController
    include_context 'Tweets'
    include_context 'Page'
    let (:authenticated) { true }

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
