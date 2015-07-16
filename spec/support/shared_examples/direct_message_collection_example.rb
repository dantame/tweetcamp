shared_examples 'Direct Message Collection' do
  include_context 'Page'

  let (:username) { nil }

  before :each do
    target_page.load
  end

  it 'shows a list of direct messages' do
    expect(target_page.dms.length).to be > 0
  end
end
