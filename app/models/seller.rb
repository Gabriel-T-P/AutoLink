class Seller < ApplicationRecord
  has_many :cars, dependent: :destroy
  has_many :contact_messages, dependent: :destroy
end
