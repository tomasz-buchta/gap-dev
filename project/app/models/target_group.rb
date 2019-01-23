class TargetGroup < ApplicationRecord
  belongs_to :parent, class_name: "TargetGroup", optional: true
  belongs_to :panel_provider

  has_and_belongs_to_many :countries
end
