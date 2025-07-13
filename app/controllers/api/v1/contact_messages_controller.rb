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
    @contact_message = ContactMessage.find(params[:id])

    render status: :ok, json: {
      seller: @contact_message.seller,
      message: @contact_message.as_json(except: [ :seller_id ]),
    }
  end
end
