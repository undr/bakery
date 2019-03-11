module Bakery::OrderingProcess
  RSpec.describe Entities::OrderItem do
    subject(:item) { described_class.new(product: product, quantity: 10) }

    let(:repo) { Bakery::OrderingProcess::ProductRepo.load(from: "./spec/fixtures/datafile") }
    let(:product) { repo.get("VS5") }
    let(:item2) { described_class.new(product: repo.get("CF"), quantity: 15) }

    describe "#merge!" do
      it "merges items" do
        item.merge!(item)

        expect(item.quantity).to eq(20)
        expect(item.product).to eq(product)
      end

      it "raises an exception if items have different products" do
        expect { item.merge!(item2) }.to raise_error(Bakery::Error)

        expect(item.quantity).to eq(10)
        expect(item.product).to eq(product)
      end
    end
  end
end
