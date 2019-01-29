class PanelProvider < ApplicationRecord
  PANEL_PROVIDERS_CODES = %w[times_a 10_arrays times_html].freeze

  has_many :countries

  validates :code, presence: true, uniqueness: true, inclusion: { in: PANEL_PROVIDERS_CODES }
end
