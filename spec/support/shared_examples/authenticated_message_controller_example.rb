shared_examples 'Authenticated Message Controller' do |method|
  include_context 'Controller', described_class
  include_context 'Messages'
  let (:app) { controller }

  it 'tries to render the template with an array of messages' do
    expect(controller.twitter).to receive(method).and_return(messages)
    expect(controller.twitter).to receive(:credentials?).and_return(true)

    expect_any_instance_of(described_class)
      .to receive(:erb)
            .with(:direct_message_collection,
                  { locals: {
                      twitter: controller.twitter,
                      dms: messages
                    }
                  }
            )

    get '/'
    expect(last_response.ok?).to be(true)
  end
end
