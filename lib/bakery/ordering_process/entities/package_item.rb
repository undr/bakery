module Bakery
  module OrderingProcess
    module Entities
      class PackageItem < Base
        property :quantity, required: true, coerce: Integer
        property :product_pack, required: true, coerce: ProductPack

        def product_quantity
          quantity * product_pack.quantity
        end

        def total_cents
          quantity * product_pack.price_cents
        end
      end
    end
  end
end
