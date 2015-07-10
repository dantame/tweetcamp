class Login

  # Exchange your oauth_token and oauth_token_secret for an AccessToken instance.


# Exchange our oauth_token and oauth_token secret for the AccessToken instance.
  access_token = prepare_access_token("abcdefg", "hijklmnop")

# use the access token as an agent to get the home timeline
  response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json")
end
