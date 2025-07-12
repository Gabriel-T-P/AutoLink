require 'rails_helper'

describe 'Guest contact seller', type: :system do
  it 'by whatsapp' do
    seller_1 = create(:seller, name: 'AutoLink - GR', phone_number: '+55 (99) 999999999')
    seller_2 = create(:seller, name: 'AutoLink - EP', phone_number: '+55 (11) 111111111')

    visit root_path

    within 'nav' do
      expect(page).to have_link 'AutoLink - GR', href: "https://wa.me/#{seller_1.phone_number.gsub(/[^0-9]/, '')}"
      expect(page).to have_link 'AutoLink - EP', href: "https://wa.me/#{seller_2.phone_number.gsub(/[^0-9]/, '')}"
    end
  end

  it 'by leaving a message in the app' do
    seller = create(:seller, name: 'AutoLink - GR', phone_number: '+55 (99) 999999999')

    visit root_path
    within 'nav' do
      click_on 'Message Us'
    end
    fill_in 'Name', with: 'Name Test'
    fill_in 'Phone', with: '11911111111'
    fill_in 'Message', with: 'Really nice car'
    select 'AutoLink - GR', from: 'Sellers'
    click_on 'Send'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Message sent with success'
  end

  it 'and view errors messages in the form' do
    
  end
end
