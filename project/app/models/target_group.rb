class TargetGroup < ApplicationRecord
  has_closure_tree

  belongs_to :panel_provider

  has_many :countries_target_groups
  has_many :countries, through: :countries_target_groups

  validates :name, presence: true
  validates :external_id, presence: true, uniqueness: true
  validates :secret_code, presence: true
  validates :parent, parent: true

  def root?
    parent_id.nil?
  end
end
