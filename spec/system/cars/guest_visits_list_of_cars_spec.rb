require 'rails_helper'

describe 'Guest visits page thats list all cars', type: :system do
  it 'as the root path' do
    car_model_1 = create(:car_model, brand: 'Hyundai', name: 'Veloster', engine: '1.2 VT', fuel_type: :flex, transmission: :automatic, year: 13.years.ago)
    car_1 = create(:car, price: 80_000, mileage: 23_600, fabricated_at: 11.years.ago, color: 'White', car_model: car_model_1)

    visit root_path

    expect(page).to have_content 'New Vehicles'
    expect(page).to have_content 'Hyundai Veloster'
    expect(page).to have_content '1.2 VT Automatic Flex'
    expect(page).to have_content '$80,000.00'
    expect(page).to have_content '23600km'
    expect(page).to have_content "#{car_1.fabricated_at.year} / #{car_1.car_model.year.year}"
    expect(page).to have_content 'White'
  end
end
