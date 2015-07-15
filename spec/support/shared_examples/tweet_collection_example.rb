require 'support/shared_contexts/page_context'

shared_examples 'Tweet Collection' do |*page_args|
  include_context 'Page'

  before :each do
    target_page.load *page_args
  end

  it 'shows a list of tweets' do
    expect(target_page.tweets.length).to be > 0
  end
end
