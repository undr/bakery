module Bakery
  module OrderingProcess
    class Packer
      attr_reader :order

      def initialize(order)
        @order = order
      end

      def prepack
        packages = order.items.map do |item|
          Entities::Package.new(
            product: item.product,
            quantity: item.quantity,
            items: Combinator.new(item).find
          )
        end

        Entities::Packages.new(packages)
      end
    end
  end
end

require_relative "./packer/context"
require_relative "./packer/combinator"
