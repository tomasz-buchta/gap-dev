require "rails_helper"

describe PricingStrategies::TenArraysPricingStrategy do
  describe "#call" do
    subject { described_class.new.call }
    around do |example|
      VCR.use_cassette "openlibrary.org" do
        example.run
      end
    end
    it { is_expected.to be_a_success }
    it { expect(subject.value!).to eq(8.6) }
  end
end
