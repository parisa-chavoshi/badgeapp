class User < ApplicationRecord
  has_many :badges, dependent: :destroy, primary_key: "external_id"

  validates :external_id, presence: true

  def owns_badge_template?(template_id)
    @badge_template_ids = badges.pluck(:badge_template_id)
    @badge_template_ids.include?(template_id)
  end

  def user_org
     x = external_id.match /\-(.*)/
     x[1]
  end

  def recipient_email 
    username = name.gsub(/\s+/, "")
    "#{username}@#{user_org}.com"
  end
end
