class PanelProvider < ApplicationRecord
  validates :code, presence: true, uniqueness: true
end
