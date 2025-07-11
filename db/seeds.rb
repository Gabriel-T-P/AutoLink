# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts 'Cleaning database...'
Car.destroy_all
CarModel.destroy_all

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

CarModel.all.each do |model|
  3.times do
    Car.create!(
      car_model: model,
      color: %w[Black White Silver Gray Red].sample,
      license_plate: Faker::Vehicle.license_plate,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      mileage: rand(5_000..80_000),
      price: rand(40_000..150_000),
      fabricated_at: rand(2..5).years.ago,
      code: SecureRandom.alphanumeric(8).upcase
    )
  end
end

puts 'Seed finished successfully'
