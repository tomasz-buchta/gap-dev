class Location < ApplicationRecord
  belongs_to :location_group

  has_many :countries_target_groups
  has_many :target_groups, through: :countries_target_groups

  validates :name, presence: true
  validates :external_id, presence: true, uniqueness: true
  validates :secret_code, presence: true
end
