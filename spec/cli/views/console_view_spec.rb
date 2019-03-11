RSpec.describe CLI::Views::ConsoleView do
  subject(:render) { view.render(template, locals) }

  let(:locals) { {} }
  let(:repo) { Bakery::OrderingProcess::ProductRepo.load(from: "./spec/fixtures/datafile") }
  let(:order) { Bakery::OrderingProcess::Entities::Order.new(items) }
  let(:item1) { Bakery::OrderingProcess::Entities::OrderItem.new(product: product1, quantity: 10) }
  let(:item2) { Bakery::OrderingProcess::Entities::OrderItem.new(product: product2, quantity: 14) }
  let(:item3) { Bakery::OrderingProcess::Entities::OrderItem.new(product: product3, quantity: 13) }
  let(:product1) { repo.get("VS5") }
  let(:product2) { repo.get("MB11") }
  let(:product3) { repo.get("CF") }
  let(:view) { described_class.new }

  describe "#report" do
    let(:template) { :report }

    it { is_expected.to eq("") }

    context "with empty order" do
      let(:locals) { { order: Bakery::OrderingProcess::Entities::Order.new } }

      it { is_expected.to eq("Empty order\n") }
    end

    context "with an order" do
      let(:items) { [item1, item2] }
      let(:locals) { { order: Bakery::OrderingProcess::Entities::Order.new(items) } }

      it { is_expected.to eq("10\tVS5\tVegemite Scroll\n14\tMB11\tBlueberry Muffin\n\n") }
    end
  end

  describe "#prepack" do
    let(:template) { :prepack }

    it { is_expected.to eq("") }

    context "with empty package" do
      let(:locals) { { packages: Bakery::OrderingProcess::Entities::Packages.new } }

      it { is_expected.to eq("We cannot pack empty order\n") }
    end

    context "with a package" do
      let(:items) { [item1, item2, item3] }
      let(:packages) { Bakery::OrderingProcess::Packer.new(order).prepack }
      let(:locals) { { packages: Bakery::OrderingProcess::Entities::Packages.new(packages) } }

      it { is_expected.to eq("10\tVS5\t$17.98\n\t2 x 5\t$8.99\n14\tMB11\t$54.8\n\t1 x 8\t$24.95\n\t3 x 2\t$9.95\n13\tCF\t$25.85\n\t2 x 5\t$9.95\n\t1 x 3\t$5.95\n") }
    end

    context "with invalid package" do
      let(:items) { [item1, item2, item3] }
      let(:packages) { Bakery::OrderingProcess::Packer.new(order).prepack }
      let(:locals) { { packages: Bakery::OrderingProcess::Entities::Packages.new(packages) } }
      let(:item3) { Bakery::OrderingProcess::Entities::OrderItem.new(product: product3, quantity: 11) }

      it { is_expected.to eq("WARNING! We cannot pack all products.\n10\tVS5\t$17.98\n\t2 x 5\t$8.99\n14\tMB11\t$54.8\n\t1 x 8\t$24.95\n\t3 x 2\t$9.95\n11\tCF\n\tWe cannot pack this order item.\n\tPlease, increase or reduce quantity of the product.\n") }
    end
  end
end
