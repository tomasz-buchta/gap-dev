require "rails_helper"
require "dry/monads/result"

RSpec.describe Api::V1::Private::TargetEvaluationController, type: :controller do
  include Dry::Monads::Result::Mixin

  include_examples "authentication"

  before do
    setup_stubs
    @controller = described_class.new
  end

  let(:setup_stubs) do
    authenticate_request
    stub_evaluate_target
  end

  let(:stub_evaluate_target) do
    AppContainer.stub(
      "evaluate_target",
      instance_double(
        EvaluateTarget,
        call: Success(locations: [{ id: 123, panel_size: 200, price: 768.33 }])
      )
    )
  end

  describe "POST #create" do
    before do
      post :create, body: {
        country_code: "PL",
        target_group_id: 1,
        locations: [
          { id: 123, panel_size: 200 }
        ]
      }
    end

    it_behaves_like "private endpoint"
    it { expect(response.status).to eq(200) }

    context "Invalid params" do
      let(:stub_evaluate_target) do
        AppContainer.stub(
          "evaluate_target",
          instance_double(
            EvaluateTarget,
            call: Failure([:validation_failed, [locations: ["missing"]]])
          )
        )
      end
      it { expect(response.status).to eq(400) }
    end

    context "Not found" do
      let(:stub_evaluate_target) do
        AppContainer.stub(
          "evaluate_target",
          instance_double(
            EvaluateTarget,
            call: Failure([:not_found, "Country not found"])
          )
        )
      end
      it { expect(response.status).to eq(404) }
      it "renders error" do
        json_body = JSON(response.body)
        expect(json_body["errors"]).to include "Country not found"
      end
    end
  end
end
