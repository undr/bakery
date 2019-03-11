module Bakery::OrderingProcess
  RSpec.describe Entities::PackageItem do
    subject(:item) { described_class.new(quantity: 5, product_pack: pack) }

    let(:pack) { Entities::ProductPack.new(quantity: 5, price_cents: 1299) }

    describe "#product_quantity" do
      its(:product_quantity) { is_expected.to eq(25) }
    end

    describe "#total_cents" do
      its(:total_cents) { is_expected.to eq(6495) }
    end
  end
end
