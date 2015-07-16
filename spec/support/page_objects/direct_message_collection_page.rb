class DirectMessageCollectionPage < SitePrism::Page
  set_url '/'

  elements :dms, '.qa-direct-message'
end
