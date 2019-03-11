module Bakery
  module OrderingProcess
    module Entities
      class OrderItem < Base
        property :product, required: true, coerce: Product
        property :quantity, required: true, coerce: Integer

        def code
          product.code
        end

        def merge!(other)
          raise Error, "Cannot merge order items with different products" unless product == other.product
          self.quantity = quantity + other.quantity
        end
      end
    end
  end
end
