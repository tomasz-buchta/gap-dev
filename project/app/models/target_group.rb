class TargetGroup < ApplicationRecord
  belongs_to :parent, class_name: "TargetGroup", optional: true
  belongs_to :panel_provider

  has_many :countries_target_groups
  has_many :countries, through: :countries_target_groups

  def root?
    parent_id.nil?
  end
end
