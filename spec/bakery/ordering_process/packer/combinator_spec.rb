module Bakery::OrderingProcess
  RSpec.describe Packer::Combinator do
    describe "#find" do
      subject(:result) { described_class.new(item).find }

      let(:repo) { Bakery::OrderingProcess::ProductRepo.load(from: "./spec/fixtures/datafile") }

      context "first" do
        let(:item) { Entities::OrderItem.new(product: product, quantity: 10) }
        let(:product) { repo.get("VS5") }

        it { is_expected.to eq([Entities::PackageItem.new(quantity: 2, product_pack: product.packs[1])]) }
      end

      context "second" do
        let(:item) { Entities::OrderItem.new(product: product, quantity: 14) }
        let(:product) { repo.get("MB11") }

        it { is_expected.to eq([
          Entities::PackageItem.new(quantity: 1, product_pack: product.packs[2]),
          Entities::PackageItem.new(quantity: 3, product_pack: product.packs[0])
        ]) }
      end

      context "third" do
        let(:item) { Entities::OrderItem.new(product: product, quantity: 13) }
        let(:product) { repo.get("CF") }

        it { is_expected.to eq([
          Entities::PackageItem.new(quantity: 2, product_pack: product.packs[1]),
          Entities::PackageItem.new(quantity: 1, product_pack: product.packs[0])
        ]) }
      end

      context "fourth" do
        let(:item) { Entities::OrderItem.new(product: product, quantity: 18) }
        let(:product) { repo.get("CF2") }

        it { is_expected.to eq([
          Entities::PackageItem.new(quantity: 3, product_pack: product.packs[1]),
          Entities::PackageItem.new(quantity: 1, product_pack: product.packs[0])
        ]) }
      end
    end
  end
end
