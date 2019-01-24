require "rails_helper"

RSpec.describe CountriesTargetGroup, type: :model do
  subject { build(:countries_target_group) }

  describe "validations" do
    context "when target_group is root" do
      it { is_expected.to be_valid }
    end

    context "when target_group is not root" do
      subject do
        build(
          :countries_target_group,
          target_group: build(:target_group, :with_parent)
        )
      end
      it { is_expected.not_to be_valid }
    end
  end
end
