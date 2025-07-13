class Api::V1::ContactMessagesController < Api::V1::ApiController
  def index
    @contact_messages = ContactMessage.all
    render json: @contact_messages, status: :ok
  end
end