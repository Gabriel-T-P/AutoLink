require 'rails_helper'

describe 'Guest view detailed information of car', type: :system do
  it 'by index page carrousel' do
    car_model_1 = create(:car_model, brand: 'Hyundai', name: 'Veloster', engine: '1.2 VT', fuel_type: :flex, transmission: :automatic, year: 13.years.ago)
    car_1 = create(:car, price: 80_000, mileage: 23_600, fabricated_at: 11.years.ago, color: 'White', car_model: car_model_1)
    car_model_2 = create(:car_model, brand: 'Crevrolet', name: 'Onix', engine: '1.0', fuel_type: :flex, transmission: :manual, year: 5.years.ago)
    car_2 = create(:car, price: 50_000, mileage: 75_447, fabricated_at: 4.years.ago, color: 'Black', car_model: car_model_2)

    visit root_path

    expect(page).to have_link href: car_path(car_1.code)
    expect(page).to have_link href: car_path(car_2.code)
  end

  it 'successfully' do
    seller = create(:seller, name: 'AutoLink - 2')
    car_model_1 = create(:car_model, brand: 'Hyundai', name: 'Veloster', engine: '1.2 VT', transmission: :automatic,
                          car_category: 'Sedan', fuel_type: :gasoline, year: 13.years.ago)
    car_1 = create(:car, price: 80_000, mileage: 23_600, fabricated_at: 11.years.ago, color: 'White', city: 'Bacabal',
                    state: 'MA', license_plate: 'LPS-9156', car_model: car_model_1, seller: seller)

    visit car_path(car_1.code)

    expect(page).to have_content "Hyundai Veloster (#{13.years.ago.year})"
    expect(page).to have_content 'Bacabal, MA'
    expect(page).to have_content 'White'
    expect(page).to have_content 'Plate: XXX-156'
    expect(page).to have_content '23.600 Km'
    expect(page).to have_content 'Sedan'
    expect(page).to have_content "Fabricated At: #{I18n.l(11.years.ago.to_date, format: :long)}"
    expect(page).to have_content 'Engine and Transmission Specifications'
    expect(page).to have_content 'Gasoline'
    expect(page).to have_content 'Automatic'
    expect(page).to have_content 'Engine: 1.2 VT'
    expect(page).to have_content '$80,000.00'
    expect(page).to have_content 'Number of Doors: 4'
    expect(page).to have_content 'Seller: AutoLink - 2'
  end
end
