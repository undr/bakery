namespace :datafile do
  def add_origin_products(repo)
    repo << Product.new(
      code: "VS5",
      name: "Vegemite Scroll",
      packs: [{
        quantity: 3,
        price_cents: 699
      }, {
        quantity: 5,
        price_cents: 899
      }]
    )
    repo << Product.new(
      code: "MB11",
      name: "Blueberry Muffin",
      packs: [{
        quantity: 2,
        price_cents: 995
      }, {
        quantity: 5,
        price_cents: 1695
      }, {
        quantity: 8,
        price_cents: 2495
      }]
    )
    repo << Product.new(
      code: "CF",
      name: "Croissant",
      packs: [{
        quantity: 3,
        price_cents: 595
      }, {
        quantity: 5,
        price_cents: 995
      }, {
        quantity: 9,
        price_cents: 1699
      }]
    )
  end

  def store(repo, filename)
    output = filename.nil? ? $stdout : File.absolute_path(filename)
    ProductRepo.save(repo, into: output)
  end

  desc "Create a datafile with data from origin test task"
  task :origin, [:filename] do |_t, args|
    require_relative "lib/bakery"
    Product = Bakery::OrderingProcess::Entities::Product
    ProductRepo = Bakery::OrderingProcess::ProductRepo

    repo = ProductRepo.new
    add_origin_products(repo)
    store(repo, args[:filename])
  end

  desc "Create a datafile with extended data"
  task :extended, [:filename] do |_t, args|
    require_relative "lib/bakery"
    Product = Bakery::OrderingProcess::Entities::Product
    ProductRepo = Bakery::OrderingProcess::ProductRepo

    repo = ProductRepo.new
    add_origin_products(repo)

    repo << Product.new(
      code: "CF2",
      name: "Origin French Croissant",
      packs: [{
        quantity: 3,
        price_cents: 595
      }, {
        quantity: 5,
        price_cents: 995
      }, {
        quantity: 11,
        price_cents: 1699
      }]
    )
    repo << Product.new(
      code: "RPAN1",
      name: "Russian Pancakes",
      packs: [{
        quantity: 2,
        price_cents: 695
      }, {
        quantity: 4,
        price_cents: 1195
      }, {
        quantity: 6,
        price_cents: 1699
      }, {
        quantity: 9,
        price_cents: 1999
      }]
    )

    store(repo, args[:filename])
  end
end
