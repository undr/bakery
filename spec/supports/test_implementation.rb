class TestImplementation
  Bakery::OrderingProcess::METHODS.each do |method|
    define_method(method) { |*args| }
  end
end
