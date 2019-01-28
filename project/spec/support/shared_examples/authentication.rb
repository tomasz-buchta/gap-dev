require "rails_helper"

RSpec.shared_examples "authentication" do
  let(:authenticate_request) do
    AppContainer.stub("authentication.verify_json_web_token", proc { %i[ok ok] })
  end
  let(:unauthenticate_request) do
    AppContainer.stub("authentication.verify_json_web_token", proc { raise AuthorizationException })
  end
end

RSpec.shared_examples "private endpoint" do
  context "without authentication" do
    include_examples "authentication"

    let(:setup_stubs) do
      unauthenticate_request
    end

    it { expect(response.status).to eq(403) }
  end
end
