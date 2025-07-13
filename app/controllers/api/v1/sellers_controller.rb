class Api::V1::SellersController < Api::V1::ApiController
  def index
    @sellers = Seller.all

    unless @sellers.empty?
      render json: @sellers, status: :ok
    else
      render status: :ok, json: { result: "There is no seller registered" }
    end
  end
end
