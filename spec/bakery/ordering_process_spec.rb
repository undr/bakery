RSpec.describe Bakery::OrderingProcess do
  describe "delegatons", bakery: true do
    Bakery::OrderingProcess::METHODS.each do |name|
      it "delegates `#{name}` method to current implementation" do
        expect(Bakery::OrderingProcess.implementation).to receive(name)
        Bakery::OrderingProcess.send(name)
      end
    end
  end
end
