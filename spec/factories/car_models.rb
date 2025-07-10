FactoryBot.define do
  factory :car_model do
    brand { "MyString" }
    name { "MyString" }
    car_category { "MyString" }
    year { "2025-07-10" }
    fuel_type { 1 }
    transmission { 1 }
    engine { "1.2" }
    doors_number { 4 }
  end
end
