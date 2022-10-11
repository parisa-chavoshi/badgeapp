desc "Populate database with users and badges from API calls"

task :populate_marvel_users do
  timestamp = Time.now.to_s 
  marvel_auth_hash = Digest::MD5.hexdigest timestamp+ENV['marvel_private_key']+ENV['marvel_public_key']

  marvel_url = "http://gateway.marvel.com/v1/public/characters"
  marvel_params = {apikey: ENV['marvel_public_key'], ts: timestamp, hash: marvel_auth_hash, limit: 100}

  response = RestClient.get marvel_url, {params: marvel_params}
  json = JSON.parse(response)["data"] 

  json["results"].map do |user|
    thumbnail = "#{user["thumbnail"]["path"]}"+"."+"#{user["thumbnail"]["extension"]}"
    thumbnail = nil if !!thumbnail.match("image_not_available")
    external_id = "#{user["id"]}"+"-marvel"
    User.create!(name: user["name"], external_id: external_id, description: user["description"], thumbnail: thumbnail)
  end
end

namespace :credly_api do 
  credly_auth_token = ENV['credly_auth_token']+":"
  auth_info = 'Basic ' + Base64.encode64( credly_auth_token ).chomp

  task :populate_badge_templates do 
    response = RestClient.get 'https://sandbox-api.credly.com/v1/organizations/cd79a0b5-2c57-421b-96c2-0979254afdb5/badge_templates', {:Authorization => auth_info}
    json = JSON.parse(response)["data"] 
    
    json.map do |badge_template|
      BadgeTemplate.create!(external_id: badge_template["id"], name: badge_template["name"], image_url: badge_template["image"]["url"])
    end
  end

  task :populate_badges do 
    response = RestClient.get 'https://sandbox-api.credly.com/v1/organizations/cd79a0b5-2c57-421b-96c2-0979254afdb5/high_volume_issued_badge_search', {:Authorization => auth_info}
    json = JSON.parse(response)["data"] 
    
    json.map do |badge|
      # to exclude other records on sandbox account
      if badge["issuer_earner_id"] && badge["badge_template"]["id"]
        Badge.create!(user_id: badge["issuer_earner_id"], badge_template_id: badge["badge_template"]["id"])
      end 
    end
  end
end 