class Api::V1::ContactMessagesController < Api::V1::ApiController
  def index
    @contact_messages = ContactMessage.all

    unless @contact_messages.empty?
      render json: @contact_messages, status: :ok
    else
      render status: :ok, json: { result: "There is no contact messages registered" }
    end
  end

  def show
  end
end
