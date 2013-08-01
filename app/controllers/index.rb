get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`

  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  
   # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)


  # at this point in the code is where you'll need to create your user account and store the access token
  User.create(username: @access_token.params["screen_name"], oauth_token: @access_token.token, oauth_secret: @access_token.secret)
  
 
  erb :index
  
end
heroku config:set TWITTER_KEY=ZIQxUVoe4mEFqymJ4AmnWg TWITTER_SECRET=rcul3Isc53X8hiH0zaqM4ZD7SsVgtcpoxO9CD1csGQ
Consumer key  ZIQxUVoe4mEFqymJ4AmnWg
Consumer secret rcul3Isc53X8hiH0zaqM4ZD7SsVgtcpoxO9CD1csGQ
