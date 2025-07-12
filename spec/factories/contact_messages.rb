FactoryBot.define do
  factory :contact_message do
    name { "MyString" }
    phone_number { "MyString" }
    message { "MyString" }
    seller
  end
end
