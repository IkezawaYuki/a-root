require 'json'

class Api::V1::InstaController < ApplicationController
  skip_before_action :verify_authenticity_token
  def confirm
    p params["hub.challenge"]
    p params["hub.verify_token"]
    render plain: params["hub.challenge"]
  end

  def webhook_notice
    p "aa"
    pp params["body"]
    json_body = params["body"]
    InstaNotices.create({json: json_body, customer_id: 1})
    render json: { message: "This is a JSON response." }, status: :ok
  end
end
