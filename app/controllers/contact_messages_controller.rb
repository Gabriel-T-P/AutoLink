class ContactMessagesController < ApplicationController
  def new
    @contact_message = ContactMessage.new
    @sellers = Seller.all
  end

  def create
    @contact_message = ContactMessage.new(contact_message_params)
    if @contact_message.save
      redirect_to root_path, notice: t(".success")
    else
      @sellers = Seller.all
      
      if params[:source] == 'cars_show' && params[:code].present?
        @car = Car.find_by(code: params[:code])
        render 'cars/show', status: :unprocessable_entity
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(:name, :phone_number, :message, :seller_id, :code, :source)
  end
end
