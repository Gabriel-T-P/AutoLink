require 'rails_helper'

describe 'Guest search for cars', type: :system do
  it 'by navbar' do
    visit root_path

    within 'nav' do
      expect(page).to have_field 'Search cars...'
      expect(page).to have_button class: 'btn-outline-primary'
    end
  end

  context 'successfully by' do
    it 'brand name' do
      seller = create(:seller, name: 'AutoLink - Vendedor Principal', phone_number: '5598981234567')
      car_model_1 = create(:car_model, brand: 'Volkswagen', name: 'Golf Highline', engine: '1.4 TSI', transmission: :automatic,
                          car_category: 'Hatch', fuel_type: :gasoline, year: Date.new(2018, 1, 1), doors_number: 4)
      car_1 = create(:car, price: 95_000, mileage: 45_000, fabricated_at: Date.new(2018, 3, 15), color: 'Silver', city: 'São Luís',
                    state: 'MA', license_plate: 'ABC-1234', code: 'VWGH0001', car_model: car_model_1, seller: seller)
      car_model_2 = create(:car_model, brand: 'Crevrolet', name: 'Onix', transmission: :manual, engine: '1.0', fuel_type: :flex)
      car_2 = create(:car, price: 50_000, mileage: 75_447, car_model: car_model_2)

      visit root_path
      fill_in 'Search cars...', with: 'Volkswagen'
      find('button.btn-outline-primary').click

      expect(current_path).to eq search_cars_path
      expect(page).to have_current_path(search_cars_path(query: 'Volkswagen'))
      expect(page).to have_content 'Golf Highline'
      expect(page).to have_content '1.4 Tsi | Automatic | Gasoline'
      expect(page).to have_content '$95,000.00'
      expect(page).to have_content '45000km'
      expect(page).to have_content "#{car_1.fabricated_at.year} / #{car_1.car_model.year.year}"
      expect(page).to have_content 'Silver'
      expect(page).not_to have_content 'Onix'
      expect(page).not_to have_content '1.0 | Manual | Flex'
    end

    it 'car name' do
      seller = create(:seller, name: 'AutoLink - Vendedor Principal', phone_number: '5598981234567')
      car_model_1 = create(:car_model, brand: 'Volkswagen', name: 'Golf Highline')
      car_1 = create(:car, car_model: car_model_1, seller: seller)
      car_model_2 = create(:car_model, brand: 'Crevrolet', name: 'Onix')
      car_2 = create(:car, car_model: car_model_2)

      visit root_path
      fill_in 'Search cars...', with: 'Onix'
      find('button.btn-outline-primary').click

      expect(page).to have_content 'Onix'
      expect(page).not_to have_content 'Golf Highline'
    end

    it 'color' do
      seller = create(:seller, name: 'AutoLink - Vendedor Principal', phone_number: '5598981234567')
      car_model_1 = create(:car_model, brand: 'Volkswagen', name: 'Golf Highline')
      car_1 = create(:car, color: 'Silver', car_model: car_model_1, seller: seller)
      car_model_2 = create(:car_model, brand: 'Crevrolet', name: 'Onix')
      car_2 = create(:car, color: 'Red', car_model: car_model_2)

      visit root_path
      fill_in 'Search cars...', with: 'Red'
      find('button.btn-outline-primary').click

      expect(page).to have_content 'Onix'
      expect(page).not_to have_content 'Golf Highline'
    end

    it 'car category' do
      car_model_1 = create(:car_model, brand: 'Volkswagen', name: 'Golf Highline', car_category: 'Hatch')
      car_1 = create(:car, car_model: car_model_1)
      car_model_2 = create(:car_model, brand: 'Crevrolet', name: 'Onix', car_category: 'Sedan')
      car_2 = create(:car, car_model: car_model_2)

      visit root_path
      fill_in 'Search cars...', with: 'Sedan'
      find('button.btn-outline-primary').click

      expect(page).to have_content 'Onix'
      expect(page).not_to have_content 'Golf Highline'
    end

    it 'engine' do
      car_model_1 = create(:car_model, brand: 'Volkswagen', name: 'Golf Highline', engine: '1.4 TSI')
      car_1 = create(:car, car_model: car_model_1)
      car_model_2 = create(:car_model, brand: 'Crevrolet', name: 'Onix', engine: '1.0')
      car_2 = create(:car, car_model: car_model_2)

      visit root_path
      fill_in 'Search cars...', with: '1.0'
      find('button.btn-outline-primary').click

      expect(page).to have_content 'Onix'
      expect(page).not_to have_content 'Golf Highline'
    end

    it 'fuel type' do
      car_model_1 = create(:car_model, brand: 'Volkswagen', name: 'Golf Highline', fuel_type: :gasoline)
      car_1 = create(:car, car_model: car_model_1)
      car_model_2 = create(:car_model, brand: 'Crevrolet', name: 'Onix', fuel_type: :flex)
      car_2 = create(:car, car_model: car_model_2)

      visit search_cars_path
      select 'Flex', from: 'Fuel type'
      click_on 'Search'

      expect(page).to have_content 'Onix'
      expect(page).not_to have_content 'Golf Highline'
    end

    it 'transmission' do
      car_model_1 = create(:car_model, brand: 'Volkswagen', name: 'Golf Highline', transmission: :manual)
      car_1 = create(:car, car_model: car_model_1)
      car_model_2 = create(:car_model, brand: 'Crevrolet', name: 'Onix', transmission: :automatic)
      car_2 = create(:car, car_model: car_model_2)

      visit search_cars_path
      select 'Automatic', from: 'Transmission'
      click_on 'Search'

      expect(page).to have_content 'Onix'
      expect(page).not_to have_content 'Golf Highline'
    end

    it 'minimum price' do
      car_model_1 = create(:car_model, brand: 'Volkswagen', name: 'Golf Highline')
      car_1 = create(:car, price: 50_000, car_model: car_model_1)
      car_model_2 = create(:car_model, brand: 'Crevrolet', name: 'Onix')
      car_2 = create(:car, price: 100_000, car_model: car_model_2)

      visit search_cars_path
      fill_in 'Minimum Price (R$)', with: '60000'
      click_on 'Search'

      expect(page).to have_content 'Onix'
      expect(page).not_to have_content 'Golf Highline'
    end

    it 'maximum price' do
      car_model_1 = create(:car_model, brand: 'Volkswagen', name: 'Golf Highline')
      car_1 = create(:car, price: 250_000, car_model: car_model_1)
      car_model_2 = create(:car_model, brand: 'Crevrolet', name: 'Onix')
      car_2 = create(:car, price: 100_000, car_model: car_model_2)

      visit search_cars_path
      fill_in 'Maximum Price (R$)', with: '150000'
      click_on 'Search'

      expect(page).to have_content 'Onix'
      expect(page).not_to have_content 'Golf Highline'
    end
  end

  it 'and returns no car' do
    visit root_path
    fill_in 'Search cars...', with: '1.0'
    find('button.btn-outline-primary').click

    expect(page).to have_content 'No car found with the current filter. Try ajusting your search'
  end
end
