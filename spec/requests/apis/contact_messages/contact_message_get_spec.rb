require 'rails_helper'

describe 'ContactMessagesControllerShow', type: :request do
  it 'should return status ok' do
    seller = create(:seller, name: 'Seller')
    message = create(:contact_message, name: 'André', phone_number: '99 999999999',
                    message: 'i want car number 10', seller: seller)

    get api_v1_contact_message_path(message)

    expect(response).to have_http_status(200)
  end

  it 'should return the contact message' do
    seller = create(:seller, name: 'Seller')
    message = create(:contact_message, name: 'André', phone_number: '99 999999999',
                    message: 'i want car number 10', seller: seller)

    get api_v1_contact_message_path(message)

    expect(response).to have_http_status(200)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response['message']['name']).to eq message.name
    expect(json_response['message']['phone_number']).to eq message.phone_number
    expect(json_response['message']['message']).to eq message.message
    expect(json_response['message']).not_to include :seller_id
    expect(json_response['seller']['id']).to eq seller.id
    expect(json_response['seller']['name']).to eq seller.name
    expect(json_response['seller']['phone_number']).to eq seller.phone_number
  end

  it 'and there is no message with given id' do
    get api_v1_contact_message_path(1)

    expect(response).to have_http_status(404)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response['result']).to eq 'No contact message was found with the given id'
  end
end
