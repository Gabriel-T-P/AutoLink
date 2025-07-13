FactoryBot.define do
  factory :seller do
    sequence(:name) { |n| "Seller Nº#{n}" }
    phone_number { "99999999" }
  end
end
