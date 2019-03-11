require_relative "./ordering_process/base_implementation"
require_relative "./ordering_process/entities"
require_relative "./ordering_process/packer"
require_relative "./ordering_process/product_repo"

module Bakery
  module OrderingProcess
    extend self
    extend Forwardable

    METHODS = %i(version get_order prepack reset add_item remove_item repo).freeze

    def_delegators :implementation, *METHODS

    def implementation=(implementation)
      @implementation = implementation
    end

    def implementation
      @implementation
    end
  end
end
