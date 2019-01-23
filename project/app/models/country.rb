class Country < ApplicationRecord
  belongs_to :panel_provider

  has_many :location_groups

  validates :code, presence: true, uniqueness: true
  validates :panel_provider, presence: true
end
