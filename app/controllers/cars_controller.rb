class CarsController < ApplicationController
  def index
    @car_models = CarModel.includes(:cars).all
  end
end
