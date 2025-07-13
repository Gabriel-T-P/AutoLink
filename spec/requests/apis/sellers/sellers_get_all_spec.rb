require 'rails_helper'

describe 'SellersControllerIndex', type: :request do
  it 'should return status ok' do
    get api_v1_sellers_path

    expect(response).to have_http_status(200)
  end

  it 'should return all sellers' do
    seller_1 = create(:seller, name: 'Seller 1', phone_number: '11 111111111')
    seller_2 = create(:seller, name: 'Seller 2', phone_number: '99 999999999')

    get api_v1_sellers_path

    expect(response).to have_http_status(200)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response[0]['name']).to eq seller_1.name
    expect(json_response[0]['phone_number']).to eq seller_1.phone_number
    expect(json_response[1]['name']).to eq seller_2.name
    expect(json_response[1]['phone_number']).to eq seller_2.phone_number
  end

  it 'and there is no message to be returned' do
    get api_v1_sellers_path

    expect(response).to have_http_status(200)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response['result']).to eq 'There is no seller registered'
  end
end
