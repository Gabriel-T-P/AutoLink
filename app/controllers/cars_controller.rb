class CarsController < ApplicationController
  def index
    @car_models = CarModel.includes(:cars).all
  end

  def show
    @car = Car.find_by!(code: params[:id])
    @contact_message = ContactMessage.new
    @sellers = Seller.all
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Carro não encontrado.'
  end
end
