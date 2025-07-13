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

    optional_params_search_filters()
  end

  private

  def optional_params_search_filters
    if params[:min_price].present?
      @cars = @cars.where("price >= ?", params[:min_price].to_i)
    end

    if params[:max_price].present?
      @cars = @cars.where("price <= ?", params[:max_price].to_i)
    end

    if params[:transmission].present?
      transmission_value = CarModel.transmissions[params[:transmission]]
      @cars = @cars.joins(:car_model).where(car_models: { transmission: transmission_value }) if transmission_value.present?
    end

    if params[:fuel_type].present?
      fuel_type_value = CarModel.fuel_types[params[:fuel_type]]
      @cars = @cars.joins(:car_model).where(car_models: { fuel_type: fuel_type_value }) if fuel_type_value.present?
    end
  end
end
