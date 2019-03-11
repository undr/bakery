module Bakery::OrderingProcess
  RSpec.describe ProductRepo do
    subject(:repo) { described_class.new }

    let(:product) do
      Entities::Product.new(
        code: "VS5",
        name: "Vegemite Scroll",
        packs: [{
          quantity: 3,
          price_cents: 699
        }, {
          quantity: 5,
          price_cents: 899
        }]
      )
    end

    describe ".load" do
      let(:repo) { described_class.load(from: "./spec/fixtures/datafile") }

      it "loads data from file" do
        expect(repo.get("VS5")).to_not be nil
        expect(repo.get("MB11")).to_not be nil
        expect(repo.get("CF")).to_not be nil
        expect(repo.get("CF2")).to_not be nil
        expect(repo.get("RPAN1")).to_not be nil
      end
    end

    describe "#put" do
      it "stores product into repo" do
        repo.put(product)
        expect(repo.get(product.code)).to eq(product)
      end
    end

    describe "#get" do
      let(:repo) { described_class.load(from: "./spec/fixtures/datafile") }

      it "retrieves product from repo by code" do
        expect(repo.get("VS5")).to eq(product)
        expect(repo.get("VS666")).to be nil
      end
    end

    describe "#get!" do
      let(:repo) { described_class.load(from: "./spec/fixtures/datafile") }

      it "retrieves product from repo by code" do
        expect(repo.get!("VS5")).to eq(product)
        expect { repo.get!("VS666") }.to raise_error(Bakery::NotFoundError)
      end
    end

    describe "#autocomplete_codes" do
      let(:repo) { described_class.load(from: "./spec/fixtures/datafile") }

      it "retrieves codes" do
        expect(repo.autocomplete_codes("")).to eq(%w{VS5 MB11 CF CF2 RPAN1})
        expect(repo.autocomplete_codes("v")).to eq(%w{VS5})
        expect(repo.autocomplete_codes("c")).to eq(%w{CF CF2})
      end
    end
  end
end
