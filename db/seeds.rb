puts 'Cleaning database...'
Car.destroy_all
CarModel.destroy_all
Seller.destroy_all

puts 'Creating sellers...'

sellers = [
  Seller.create!(name: 'AutoLink - Campus', phone_number: '+55 (11) 91234-5678'),
  Seller.create!(name: 'AutoLink - Maranhão', phone_number: '+55 (98) 98765-4321'),
  Seller.create!(name: 'AutoLink - Curitiba', phone_number: '+55 (41) 92345-6789')
]

puts 'Creating car models...'

car_models = [
  {
    brand: 'Toyota',
    name: 'Corolla',
    car_category: 'Sedan',
    year: Date.new(2022),
    fuel_type: :flex,
    transmission: :automatic,
    engine: '2.0',
    doors_number: 4
  },
  {
    brand: 'Volkswagen',
    name: 'T-Cross',
    car_category: 'SUV',
    year: Date.new(2023),
    fuel_type: :gasoline,
    transmission: :automatic,
    engine: '1.4 TSI',
    doors_number: 4
  },
  {
    brand: 'Fiat',
    name: 'Mobi',
    car_category: 'Hatch',
    year: Date.new(2021),
    fuel_type: :flex,
    transmission: :manual,
    engine: '1.0',
    doors_number: 4
  }
]

car_models.each do |attrs|
  CarModel.create!(attrs)
end

puts 'Creating cars...'

test_images_path = [
  Rails.root.join('db/seeds/fff.png'),
  Rails.root.join('db/seeds/sample_image_full.jpg'),
  Rails.root.join('db/seeds/sample_2.png')
]

CarModel.all.each do |model|
  3.times do
    car = Car.create!(
      car_model: model,
      seller: sellers.sample,
      color: %w[Black White Silver Gray Red].sample,
      license_plate: Faker::Vehicle.license_plate,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      mileage: rand(5_000..80_000),
      price: rand(40_000..150_000),
      fabricated_at: rand(1..3).years.ago,
      code: SecureRandom.alphanumeric(8).upcase
    )

    3.times do
      car.images.attach(
        io: File.open(test_images_path.sample),
        filename: 'sample-image-full.jpg'
      )
    end
  end
end

puts 'Seeds finished successfully'
