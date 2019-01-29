require "rails_helper"

RSpec.describe Api::V1::Public::LocationsController, type: :controller do
  include Dry::Monads::Result::Mixin

  before do
    setup_stubs
    @controller = described_class.new
  end

  let(:setup_stubs) do
    AppContainer.stub(
      "location_repository",
      instance_double(
        LocationRepository,
        locations_by_country_code: Success([build_stubbed(:location, name: "DuckVille")])
      )
    )
  end

  describe "GET #show" do
    before do
      get :show, params: { country_code: "PL" }
    end
    it { expect(response.status).to eq(200) }
    it do
      json_body = JSON(response.body)
      expect(json_body["data"].first["attributes"]["name"]).to eq("DuckVille")
    end
  end
end
