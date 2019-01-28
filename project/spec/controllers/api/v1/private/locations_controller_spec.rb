require "rails_helper"
require "dry/monads/result"

RSpec.describe Api::V1::Private::LocationsController, type: :controller do
  include Dry::Monads::Result::Mixin

  include_examples "authentication"

  before do
    setup_stubs
    stub_location
    @controller = described_class.new
  end

  let(:setup_stubs) do
    stub_location
  end

  let(:stub_location) do
    AppContainer.stub(
      "location_repository",
      instance_double(
        LocationRepository,
        locations_by_country_code: Success([build_stubbed(:location)])
      )
    )
  end

  describe "GET #show" do
    before do
      get :show, params: { country_code: "PL" }
    end
    it_behaves_like "private endpoint"

    context "when authorized" do
      let(:setup_stubs) do
        stub_location
        authenticate_request
      end
      it { expect(response.status).to eq(200) }
      it {
        json_body = JSON(response.body)
        expect(json_body["data"].first["attributes"]).to be_an_instance_of(Hash)
      }
    end
  end
end
