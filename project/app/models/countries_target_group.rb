class CountriesTargetGroup < ApplicationRecord
  belongs_to :country
  belongs_to :target_group

  validates :target_group, root: true
end
