class Badge < ApplicationRecord
  belongs_to :user, primary_key: "external_id"
  belongs_to :badge_template, primary_key: "external_id"

  validates :user_id, presence: true
  validates :badge_template_id, presence: true
  validates_uniqueness_of :badge_template_id, scope: [:user_id]
end
