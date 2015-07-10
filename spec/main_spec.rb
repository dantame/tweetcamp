require 'spec_helper'
require 'main'

# Tests the entry point of the app
module TweetCamp
  describe Main do
    subject { described_class.new twitter_app_key, twitter_app_secret }
    let(:twitter_app_key) { 'B82hBVmCwdmytssDy0ERKMjMp' }
    let(:twitter_app_secret) do
      'zUV7DOnXR55fDEYiVy9kE88qBV3CmkW2XVAVLCWX4OLRaPcwrE'
    end

    context 'setup' do
      it 'initializes with an instance of the twitter gem' do
        expect(subject.twitter).to be(Twitter::REST::Client)
      end
    end
  end
end
