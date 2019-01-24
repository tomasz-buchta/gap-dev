class Country < ApplicationRecord
  belongs_to :panel_provider

  has_many :location_groups

  has_many :countries_target_groups
  has_many :target_groups, through: :countries_target_groups

  validates :code, presence: true, uniqueness: true
  validates :panel_provider, presence: true
end
