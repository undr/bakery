module Bakery::OrderingProcess
  RSpec.describe Entities::Package do
    subject(:package) { described_class.new(product: product, quantity: 15, items: items) }

    let(:repo) { Bakery::OrderingProcess::ProductRepo.load(from: "./spec/fixtures/datafile") }
    let(:product) { repo.get("CF2") }
    let(:items) { [] }

    describe "#code" do
      its(:code) { is_expected.to eq("CF2") }
    end

    describe "#valid?" do
      it { is_expected.to_not be_valid }

      context "with valid items" do
        let(:items) { [double(:item, product_quantity: 10), double(:item, product_quantity: 5)] }
        it { is_expected.to be_valid }
      end

      context "with invalid items" do
        let(:items) { [double(:item, product_quantity: 5), double(:item, product_quantity: 5)] }
        it { is_expected.to_not be_valid }
      end
    end

    describe "#total_cents" do
      its(:total_cents) { is_expected.to be_zero }

      context "with items" do
        let(:items) { [double(:item, total_cents: 1295), double(:item, total_cents: 595)] }
        its(:total_cents) { is_expected.to eq(1890) }
      end
    end
  end
end
