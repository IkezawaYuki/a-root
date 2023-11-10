require 'json'

class Api::V1::InstaController < ApplicationController
  skip_before_action :verify_authenticity_token
  def confirm
    render json: { message: "This is a JSON response." }, status: :ok
  end

  def webhook_notice
    json_body = request.body.read
    InstaNotices.create({json: json_body, customer_id: 0})
    render json: { message: "This is a JSON response." }, status: :ok
  end
end
