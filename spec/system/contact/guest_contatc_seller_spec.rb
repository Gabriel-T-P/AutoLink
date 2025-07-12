require 'rails_helper'

describe 'Guest contact seller', type: :system do
  it 'by navbar' do
    seller_1 = create(:seller, name: 'AutoLink - GR', phone_number: '+55 (99) 999999999')
    seller_2 = create(:seller, name: 'AutoLink - EP', phone_number: '+55 (11) 111111111')

    visit root_path

    within 'nav' do
      expect(page).to have_link 'AutoLink - GR', href: "https://wa.me/#{seller_1.phone_number.gsub(/[^0-9]/, '')}"
      expect(page).to have_link 'AutoLink - EP', href: "https://wa.me/#{seller_2.phone_number.gsub(/[^0-9]/, '')}"
    end
  end
end
