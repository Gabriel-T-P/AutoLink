class ContactMessagesController < ApplicationController
  def new
    @contact_message = ContactMessage.new
    @sellers = Seller.all
  end
end
