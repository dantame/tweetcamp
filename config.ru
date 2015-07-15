require 'dotenv'
require_relative 'lib/controllers/timeline_controller'
require_relative 'lib/controllers/mentions_controller'
require_relative 'lib/controllers/login_controller'
require_relative 'lib/twitter_adapter'
Dotenv.load if ENV['RACK_ENV'] != 'production'

twitter = TweetCamp::TwitterAdapter.new(ENV['TWITTER_CONSUMER_KEY'],
                                        ENV['TWITTER_CONSUMER_SECRET'])

links = [{url: '/timeline', name: 'Timeline'}]

map '/timeline' do
  timeline_controller = TweetCamp::TimelineController
  timeline_controller.set :twitter, twitter
  timeline_controller.set :links, links

  run timeline_controller.new
end

map '/mentions' do
  mentions_controller = TweetCamp::MentionsController
  mentions_controller.set :twitter, twitter
  mentions_controller.set :links, links

  run mentions_controller.new
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
