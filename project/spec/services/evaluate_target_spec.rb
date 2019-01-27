require "rails_helper"
require "dry/monads/result"

describe EvaluateTarget do
  include Dry::Monads::Result::Mixin

  let(:params) do
    {
      country_code: "PL",
      target_group_id: 1,
      locations: [
        { id: 123, panel_size: 200 }
      ]
    }
  end
  before do
    AppContainer.stub(
      "validate_evaluate_target_params",
      double(call: Success(params))
    )
  end
  let!(:country) { create(:country) }
  subject { described_class.new.call(params) }
  describe "#call" do
    it { is_expected.to be_a_success }
  end
end
