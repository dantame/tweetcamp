class TimelinePage < SitePrism::Page
  set_url '/'

  elements :tweets, '.qa-tweet'
end
