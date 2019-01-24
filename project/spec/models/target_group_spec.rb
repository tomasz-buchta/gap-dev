require "rails_helper"

RSpec.describe TargetGroup, type: :model do
  describe "validations" do
    let(:target_group) { build(:target_group) }
    it "cannot be parent to itself" do
      target_group.parent = target_group
      expect(target_group).not_to be_valid
    end
  end
end
