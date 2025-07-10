FactoryBot.define do
  factory :car do
    car_model
    code { SecureRandom.alphanumeric(8) }
    color { "MyString" }
    license_plate { "MyString" }
    city { "MyString" }
    state { "MyString" }
    mileage { 10000 }
    price { 10000 }
    fabricated_at { "2025-07-10 19:00:30" }
  end
end
