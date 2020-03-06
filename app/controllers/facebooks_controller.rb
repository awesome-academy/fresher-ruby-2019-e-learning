class FacebooksController < ApplicationController
  require 'net/http'
  
  def login_facebook
    response_body = generic_callback
    access_token = response_body["access_token"]
    details = get_information_user access_token
    user = User.find_by email: details["email"]

    if user.present?
      user.update! access_token: access_token if user.present?
    else
      user = User.create email: details["email"], name: details["name"], password: SecureRandom.urlsafe_base64, access_token: access_token
      user.activate
    end
    login user
    redirect_to user_path(user)
  end

  def show
    facebook_omauth = "#{ENV['FACEBOOK_OMAUTH']}"
    redirect_to facebook_omauth
  end

  private

  def load_api_request endpoint
    uri = URI "https://graph.facebook.com/v3.2/#{endpoint}"
    response_body = JSON.parse Net::HTTP.get_response(uri).body
  end
  
  def generic_callback
    load_api_request "oauth/access_token?client_id=#{ENV['FACEBOOK_APP_ID']}&client_secret=#{ENV['FACEBOOK_APP_SECRET']}&code=#{params[:code]}&redirect_uri=#{ENV['FACEBOOK_APP_URL']}"
  end

  def get_information_user access_token
    load_api_request "me?fields=email,name&access_token=#{access_token}"
  end
end
