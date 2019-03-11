module Bakery::OrderingProcess
  RSpec.describe Entities::Order do
    subject(:order) { described_class.new }

    let(:repo) { Bakery::OrderingProcess::ProductRepo.load(from: "./spec/fixtures/datafile") }
    let(:item) { Entities::OrderItem.new(product: product, quantity: 10) }
    let(:product) { repo.get("VS5") }

    describe "#add" do
      it "adds item into order" do
        order.add(item)
        expect(order.items).to include(item)
      end

      it "merges items with the same product" do
        order.add(item)
        order.add(item)

        expect(order.items[0].quantity).to eq(20)
        expect(order.items[0].product).to eq(product)
      end
    end

    describe "#remove" do
      subject(:order) { described_class.new([item]) }

      it "removes item into order" do
        order.remove("VS5")
        expect(order).to be_empty
      end
    end
  end
end
