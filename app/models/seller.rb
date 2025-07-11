class Seller < ApplicationRecord
  has_many :cars, dependent: :destroy
end
