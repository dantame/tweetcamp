class TweetCollectionPage < SitePrism::Page
  set_url '/{/username}'

  elements :tweets, '.qa-tweet'
end
