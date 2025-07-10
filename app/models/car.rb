class Car < ApplicationRecord
  belongs_to :car_model

  def to_param
    code
  end
end
