require 'rails_helper'

describe 'ContactMessagesControllerIndex', type: :request do
  it 'should return status ok' do
    get api_v1_contact_messages_path

    expect(response).to have_http_status(200)
  end

  it 'should return all contact messages' do
    seller_1 = create(:seller, name: 'Seller 1')
    seller_2 = create(:seller, name: 'Seller 1')
    message = create(:contact_message, name: 'André', phone_number: '99 999999999',
                    message: 'i want car number 10', seller: seller_1)
    other_message = create(:contact_message, name: 'Júnior', phone_number: '11 111111111',
                    message: 'talk about number of available cars', seller: seller_2)

    get api_v1_contact_messages_path

    expect(response).to have_http_status(200)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response[0]['name']).to eq message.name
    expect(json_response[0]['phone_number']).to eq message.phone_number
    expect(json_response[0]['message']).to eq message.message
    expect(json_response[0]['seller_id']).to eq seller_1.id
    expect(json_response[1]['name']).to eq other_message.name
    expect(json_response[1]['phone_number']).to eq other_message.phone_number
    expect(json_response[1]['message']).to eq other_message.message
    expect(json_response[1]['seller_id']).to eq seller_2.id
  end

  it 'and there is no message to be returned' do
    get api_v1_contact_messages_path

    expect(response).to have_http_status(200)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response['result']).to eq 'There is no contact messages registered'
  end
end
