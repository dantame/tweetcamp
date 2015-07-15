require 'support/shared_contexts/page_context'

shared_examples 'Tweet Collection' do
  include_context 'Page'

  let (:username) { nil }

  before :each do
    if username
      target_page.load(username: username)
    else
      target_page.load
    end
  end

  it 'shows a list of tweets' do
    expect(target_page.tweets.length).to be > 0
  end
end
