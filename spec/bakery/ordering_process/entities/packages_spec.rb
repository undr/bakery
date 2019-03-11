module Bakery::OrderingProcess
  RSpec.describe Entities::Packages do
    subject(:packages) { described_class.new(items) }

    let(:items) { [] }

    it "cannot be mutated" do
      packages = described_class.new(["package1", "package2"])
      expect { packages << "package3" }.to raise_error(RuntimeError)
      expect(packages).to eq(["package1", "package2"])
    end

    describe "#valid?" do
      it { is_expected.to be_valid }

      context "with valid packages" do
        let(:items) { [double(:package, valid?: true), double(:package, valid?: true)] }
        it { is_expected.to be_valid }
      end

      context "with at least one invalid package" do
        let(:items) { [double(:package, valid?: true), double(:package, valid?: false)] }
        it { is_expected.to_not be_valid }
      end
    end
  end
end
