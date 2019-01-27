require "rails_helper"
require "dry/monads/result"

RSpec.describe Api::V1::Private::TargetEvaluationController, type: :controller do
  include Dry::Monads::Result::Mixin

  before do
    setup_stubs
    @controller = described_class.new
  end

  let(:setup_stubs) do
    AppContainer.stub(
      "location_repository",
      instance_double(LocationRepository, locations_by_country_code: Success([]))
    )
  end

  describe "GET #show" do
    before do
      post :create, params: {
        country_code: "PL",
        target_group_id: 1,
        locations: [
          { id: 123, panel_size: 200 }
        ]
      }
    end
    it { expect(response.status).to eq(200) }
  end

end
