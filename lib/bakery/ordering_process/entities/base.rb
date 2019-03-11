module Bakery
  module OrderingProcess
    module Entities
      class Base < Hashie::Trash
        include Hashie::Extensions::IndifferentAccess
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Dash::Coercion
      end
    end
  end
end
