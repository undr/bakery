module Bakery
  module OrderingProcess
    module Entities
      class ProductPack < Base
        include Comparable

        property :quantity, required: true, coerce: Integer
        property :price_cents, required: true, coerce: Integer

        def <=>(other)
          other.quantity <=> quantity
        end
      end
    end
  end
end
