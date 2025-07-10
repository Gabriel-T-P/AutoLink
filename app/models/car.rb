class Car < ApplicationRecord
  has_many_attached :images
  belongs_to :car_model

  def to_param
    code
  end
end
