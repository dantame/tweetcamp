require_relative 'lib/controllers/timeline_controller'
require_relative 'lib/controllers/login_controller'
require_relative 'lib/twitter_adapter'

twitter = TweetCamp::TwitterAdapter.new('B82hBVmCwdmytssDy0ERKMjMp',
                                        'zUV7DOnXR55fDEYiVy9kE88qBV3CmkW2XVAVLCWX4OLRaPcwrE')

links = [{url: '/timeline', name: 'Timeline'}]

map '/timeline' do
  timeline_controller = TweetCamp::TimelineController
  timeline_controller.set :twitter, twitter
  timeline_controller.set :links, links

  run timeline_controller.new
end

map '/login' do
  login_controller = TweetCamp::LoginController
  login_controller.set :twitter, twitter
  login_controller.set :links, links

  run login_controller.new
end

map '/' do
  login_controller = TweetCamp::LoginController
  login_controller.set :twitter, twitter
  login_controller.set :links, links

  run login_controller.new
end
