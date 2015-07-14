RSpec.shared_context "Tweets" do
  let (:tweets) do
    [Twitter::Tweet.new({id: 1}),
     Twitter::Tweet.new({id: 2}),
     Twitter::Tweet.new({id: 3}),
     Twitter::Tweet.new({id: 4})]
  end
end
