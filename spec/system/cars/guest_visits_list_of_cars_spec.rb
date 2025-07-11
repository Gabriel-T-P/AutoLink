require 'rails_helper'

describe 'Guest visits page thats list all cars', type: :system do
  it 'as the root path' do
    car_model_1 = create(:car_model, brand: 'Hyundai', name: 'Veloster', engine: '1.2 VT', fuel_type: :flex, transmission: :automatic, year: 13.years.ago)
    car_1 = create(:car, price: 80_000, mileage: 23_600, fabricated_at: 11.years.ago, color: 'White', car_model: car_model_1)
    car_model_2 = create(:car_model, brand: 'Crevrolet', name: 'Onix', engine: '1.0', fuel_type: :flex, transmission: :manual, year: 5.years.ago)
    car_2 = create(:car, price: 50_000, mileage: 75_447, fabricated_at: 4.years.ago, color: 'Black', car_model: car_model_2)

    visit root_path

    expect(page).to have_content 'New vehicles per brand'
    expect(page).to have_content 'Hyundai Veloster'
    expect(page).to have_content '1.2 Vt | Automatic | Flex'
    expect(page).to have_content '$80,000.00'
    expect(page).to have_content '23600km'
    expect(page).to have_content "#{car_1.fabricated_at.year} / #{car_1.car_model.year.year}"
    expect(page).to have_content 'White'
    expect(page).to have_content 'Crevrolet Onix'
    expect(page).to have_content '1.0 | Manual | Flex'
    expect(page).to have_content '$50,000.00'
    expect(page).to have_content '75447km'
    expect(page).to have_content "#{car_2.fabricated_at.year} / #{car_2.car_model.year.year}"
    expect(page).to have_content 'Black'
  end

  it 'and does not show any empty car_model' do
    car_model_1 = create(:car_model, brand: 'Hyundai', name: 'Veloster')
    car_1 = create(:car, car_model: car_model_1)
    car_model_2 = create(:car_model, brand: 'Crevrolet', name: 'Onix')

    visit root_path

    expect(page).to have_content 'Hyundai Veloster'
    expect(page).not_to have_content 'Hyundai Veloster'
  end
end
