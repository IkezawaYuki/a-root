require "http"

class FacebookClient
  def self.get_long_term_token access_token
    p "get_long_term_token"
    params = {}
    params[:access_token] = access_token
    params[:client_id] = ARoot::Application.config.facebook_app_id
    params[:client_secret] = ARoot::Application.config.facebook_app_secret
    p params
    response = HTTP.get("https://graph.facebook.com/v18.0/oauth/client_code", :params => params)
    p response
    response.body["access_token"]
  end

  def get_posts

  end
end