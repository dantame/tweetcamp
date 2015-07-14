require 'support/page_objects/timeline_page'
require 'controllers/timeline_controller'
require 'support/shared_contexts/controller_context'
require 'support/shared_contexts/tweets_context'

module TweetCamp
  describe 'Timeline', :type => :feature do
    include_context 'Controller', TweetCamp::TimelineController
    include_context 'Tweets'
    let (:authenticated) { true }
    let (:request_token) { double() }
    let (:timeline_page) { TimelinePage.new }

    before :each do
      allow(controller.twitter).to receive(:authorize_url).and_return('test')
      allow(controller.twitter).to receive(:user_timeline).and_return(tweets)
      allow(controller.twitter).to receive(:credentials?).and_return(authenticated)
      timeline_page.load
    end

    context '/' do
      context 'user is authenticated' do
        it 'shows the tweets of the logged in user when the url slug is omitted' do
          expect(timeline_page.tweets.length).to be > 0
        end
      end

      context 'user is not authenticated' do
        let (:authenticated) { false }
        it 'redirects to /login if the user is not authenticated' do
          expect(page.current_url).to include('/login')
        end
      end
    end

    context '/?:username?' do
      context 'user is authenticated' do
        it 'shows the tweets of the username in the url slug when logged in' do
          expect(timeline_page.tweets.length).to be > 0
        end
      end

      context 'user is not authenticated' do
        let (:authenticated) { false }
        it 'shows the tweets of the username in the url slug when not logged in' do
          expect(timeline_page.tweets.length).to be > 0
        end
      end
    end
  end
end
