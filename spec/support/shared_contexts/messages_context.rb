RSpec.shared_context "Messages" do
  let (:messages) do
    [Twitter::DirectMessage.new({id: 1}),
     Twitter::DirectMessage.new({id: 2}),
     Twitter::DirectMessage.new({id: 3}),
     Twitter::DirectMessage.new({id: 4})]
  end
end
