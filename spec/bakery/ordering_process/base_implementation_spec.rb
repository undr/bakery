module Bakery::OrderingProcess
  RSpec.describe BaseImplementation do
    subject(:implementation) { described_class.new(repo) }

    let(:repo) { Bakery::OrderingProcess::ProductRepo.load(from: "./spec/fixtures/datafile") }
    let(:order_item) { Entities::OrderItem.new(product: product, quantity: 10) }
    let(:product) { repo.get("CF") }

    describe "#version" do
      it { expect(implementation.version).to eq(Bakery::VERSION) }
    end

    describe "#get_order" do
      it { expect(implementation.get_order).to be_instance_of(Entities::Order) }
      it { expect(implementation.get_order).to be_empty }

      it "returns the same order every time" do
        expect(implementation.get_order).to be_instance_of(Entities::Order)
        expect(implementation.get_order).to be_empty
        implementation.get_order.add(order_item)
        expect(implementation.get_order).to_not be_empty
      end
    end

    describe "#prepack" do
      subject(:packages) { implementation.prepack(order) }

      context "when valid" do
        let(:order) do
          Entities::Order.new.tap do |order|
            order.add(Entities::OrderItem.new(product: repo.get("VS5"), quantity: 10))
            order.add(Entities::OrderItem.new(product: repo.get("MB11"), quantity: 13))
            order.add(Entities::OrderItem.new(product: repo.get("CF"), quantity: 14))
          end
        end

        it { is_expected.to be_instance_of(Entities::Packages) }
        it { is_expected.to have(3).items }
        it { is_expected.to be_valid }
      end

      context "when invalid" do
        let(:order) do
          Entities::Order.new.tap do |order|
            order.add(Entities::OrderItem.new(product: repo.get("VS5"), quantity: 10))
            order.add(Entities::OrderItem.new(product: repo.get("MB11"), quantity: 12))
            order.add(Entities::OrderItem.new(product: repo.get("CF"), quantity: 11))
          end
        end

        it { is_expected.to be_instance_of(Entities::Packages) }
        it { is_expected.to have(3).items }
        it { is_expected.to_not be_valid }
      end
    end

    describe "#reset" do
      it "resets the order" do
        expect(implementation.get_order).to be_empty
        implementation.get_order.add(order_item)
        expect(implementation.get_order).to_not be_empty
        implementation.reset
        expect(implementation.get_order).to be_empty
      end
    end

    describe "#add_item" do
      it "add product into the order" do
        implementation.add_item("CF", 10)
        expect(implementation.get_order.items).to have(1).item
        expect(implementation.get_order.items).to include(order_item)
      end

      it "increases quantity of existing product" do
        order = Entities::Order.new
        implementation.add_item("CF", 7)
        implementation.add_item("CF", 3)
        expect(implementation.get_order.items).to have(1).item
        expect(implementation.get_order.items).to include(order_item)
      end
    end

    describe "#remove_item" do
      it "removes product from the order" do
        order = Entities::Order.new
        implementation.add_item("CF", 10)
        implementation.add_item("MB11", 3)
        implementation.remove_item("MB11")
        expect(implementation.get_order.items).to have(1).item
        expect(implementation.get_order.items).to include(order_item)
      end
    end
  end
end
