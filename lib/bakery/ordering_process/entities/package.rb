module Bakery
  module OrderingProcess
    module Entities
      class Package
        attr_reader :product, :quantity, :items

        def initialize(product:, quantity:, items:)
          @quantity = quantity
          @product = product
          @items = items
        end

        def code
          product.code
        end

        def valid?
          !items.empty? && quantity == calculate_quantity
        end

        def total_cents
          items.sum(&:total_cents)
        end

        private

        def calculate_quantity
          items.sum(&:product_quantity)
        end
      end
    end
  end
end
