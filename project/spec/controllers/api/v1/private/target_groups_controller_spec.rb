require "rails_helper"

RSpec.describe Api::V1::Private::TargetGroupsController, type: :controller do
  include Dry::Monads::Result::Mixin

  include_examples "authentication"

  before do
    setup_stubs
    @controller = described_class.new
  end

  let(:stub_repo) do
    AppContainer.stub(
      "target_group_repository",
      instance_double(TargetGroupRepository, by_country_code: Success([]))
    )
  end

  let(:setup_stubs) do
    stub_repo
    authenticate_request
  end

  describe "GET #show" do
    before do
      get :show, params: { country_code: "PL" }
    end

    it { expect(response.status).to eq(200) }

    it_behaves_like "private endpoint"
  end
end
