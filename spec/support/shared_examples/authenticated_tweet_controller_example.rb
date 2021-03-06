shared_examples 'Authenticated Tweet Controller' do |method|
  include_context 'Controller', described_class
  include_context 'Tweets'
  let (:app) { controller }

  it 'tries to render the template with an array of tweets' do
    expect(controller.twitter).to receive(method).and_return(tweets)
    expect(controller.twitter).to receive(:credentials?).and_return(true)

    expect_any_instance_of(described_class)
      .to receive(:erb)
            .with(:tweet_collection,
                  { locals: {
                      twitter: controller.twitter,
                      tweets: tweets
                    }
                  }
            )

    get '/'
    expect(last_response.ok?).to be(true)
  end
end
