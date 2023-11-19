require 'googleauth'

class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_login?, except: :auth
  def index
    # GET "https://graph.facebook.com/{graph-api-version}/oauth/access_token?
    #     grant_type=fb_exchange_token&
    #     client_id={app-id}&
    #     client_secret={app-secret}&
    #     fb_exchange_token={your-access-token}"
    @customers = Customer.all

  end

  def facebook_auth
    p params
    short_token = params[:accessToken]
    p "short_token"
    p short_token
    long_token = FacebookClient.get_long_term_token short_token
    p "long_token"
    p long_token
    user = User.find_by(session_token: session[:session_token])
    customer = Customer.find_by(user_id: user.id)
    customer.facebook_token = long_token
    customer.save!
    redirect_to "/"
  end

  def auth
    payload = Google::Auth::IDTokens.verify_oidc(params[:credential],
                                                 aud: "833049088433-acug9f9ujg4i245kg5rtud3jvk2rpplg.apps.googleusercontent.com")
    user = User.find_by(email: payload["email"])
    if user.nil?
      redirect_to "/home/login", alert: "権限がありません"
    else
      session[:email] = payload["email"]
      session[:session_token] = payload["sub"]
      session[:picture] = payload["picture"]
      user.session_token = payload["sub"]
      user.picture = payload["picture"]
      user.save!
      redirect_to "/"
    end

  end

  def is_login?
    user = User.find_by(session_token: session[:session_token]) if session[:session_token]
    if user.nil?
      redirect_to "/admin/login"
    end
  end

  def logout
    if session[:session_token]
      user = User.find_by(session_token: session[:session_token])
      if user
        user.session_token = nil
        user.save!
      end
      session.delete(:email)
      session.delete(:session_token)
      session.delete(:picture)
      render "/admin/login"
    end
  end
end