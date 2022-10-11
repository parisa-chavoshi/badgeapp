class BadgesController < ApplicationController
  def create
    json =  post_api_call
    
    Badge.create!(user_id: json["issuer_earner_id"], badge_template_id: json["badge_template"]["id"])
    redirect_to :users
  end

  private
  def post_api_call
    credly_auth_token = ENV['credly_auth_token']+":"
    auth_info = 'Basic ' + Base64.encode64( credly_auth_token ).chomp

    response = RestClient.post 'https://sandbox-api.credly.com/v1/organizations/cd79a0b5-2c57-421b-96c2-0979254afdb5/badges', badge_params.to_json, {:content_type => :json, :accept => :json, :Authorization => auth_info}
    JSON.parse(response)["data"] 
  end

  def badge_params
    params.require(:badge).permit(:recipient_email, :issued_to_first_name, :issued_to_last_name, :badge_template_id, :issued_at, :issuer_earner_id, :suppress_badge_notification_email)
  end
end
