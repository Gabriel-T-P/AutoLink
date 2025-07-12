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
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(:name, :phone_number, :message, :seller_id)
  end
end
