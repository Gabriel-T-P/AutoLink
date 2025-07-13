class CarsController < ApplicationController
  def index
    @car_models = CarModel.includes(:cars).all
  end

  def show
    @car = Car.find_by!(code: params[:id])
    @contact_message = ContactMessage.new
    @sellers = Seller.all
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: t(".car_not_found")
  end

  def search
    @cars = Car.all

    if params[:query].present?
      search_term = "%#{params[:query].downcase}%"
      @cars = @cars.joins(:car_model)
                    .where("LOWER(cars.color) LIKE :search_term OR
                            LOWER(car_models.brand) LIKE :search_term OR
                            LOWER(car_models.name) LIKE :search_term OR
                            LOWER(car_models.car_category) LIKE :search_term OR
                            LOWER(car_models.engine) LIKE :search_term",
                           search_term: search_term)
    end
  end
end
