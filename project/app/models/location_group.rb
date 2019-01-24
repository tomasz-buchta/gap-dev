class LocationGroup < ApplicationRecord
  belongs_to :country
  belongs_to :panel_provider

  validates :name, presence: true
end
