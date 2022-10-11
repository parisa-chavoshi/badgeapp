class BadgeTemplate < ApplicationRecord
  has_many :badges, dependent: :destroy

  validates :external_id, presence: true
end
