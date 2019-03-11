module Bakery
  class Error < StandardError
  end

  class NotFoundError < Error
    attr_reader :code

    def initialize(code)
      @code = code
      super("Cannot find a product with `#{code}` code.")
    end
  end
end
