require 'controllers/direct_messages_controller'

module TweetCamp
  describe DirectMessageCollectionPage, :type => :feature do
    include_context 'Controller', TweetCamp::DirectMessagesController
    include_context 'Messages'
    include_context 'Page'
    let (:authenticated) { true }

    before :each do
      allow(controller.twitter).to receive(:authorize_url).and_return('test')
      allow(controller.twitter).to receive(:direct_messages).and_return(messages)
      allow(controller.twitter).to receive(:credentials?).and_return(authenticated)
    end

    context '/' do
      context 'user is authenticated' do
        it_behaves_like 'Direct Message Collection'
      end
    end

  end
end
