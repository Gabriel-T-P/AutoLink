class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :seller

  has_many_attached :images
end
