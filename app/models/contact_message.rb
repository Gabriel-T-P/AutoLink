class ContactMessage < ApplicationRecord
  belongs_to :seller

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :phone_number, presence: true, format: { with: /\A\(?\d{2}\)?\s?\d{4,5}-?\d{4}\z/, message: :invalid_phone_format }
  validates :message, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :seller_id, presence: true
end
