require "rails_helper"
require "dry/monads/result"

RSpec.describe Api::V1::Private::LocationsController, type: :controller do
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
      get :show, params: { country_code: "PL" }
    end
    it { expect(response.status).to eq(200) }
  end
end
