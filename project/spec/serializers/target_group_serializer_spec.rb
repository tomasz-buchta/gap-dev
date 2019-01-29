require "rails_helper"

RSpec.describe TargetGroupSerializer do
  let(:params) { {} }
  subject(:attribute_keys) do
    described_class
      .new(build_stubbed(:target_group), params: params)
      .serializable_hash[:data][:attributes]
      .keys
  end

  it { is_expected.not_to include(:secret_code) }
  context "with private == true" do
    let(:params) { { private: true } }
    it { is_expected.to include(:secret_code) }
  end
end
