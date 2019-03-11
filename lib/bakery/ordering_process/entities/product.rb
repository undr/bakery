module Bakery
  module OrderingProcess
    module Entities
      class Product < Base
        property :code, required: true
        property :name, required: true
        property :packs, coerce: Array[ProductPack]
      end
    end
  end
end
