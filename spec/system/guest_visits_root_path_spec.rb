require 'rails_helper'

describe 'guest visits root path', type: :system do
  it 'and view navbar' do
    visit root_path

    within 'nav' do
      expect(page).to have_link 'Cars', href: cars_path
      expect(page).to have_link 'Contact Us'
      expect(page).to have_link 'English'
      expect(page).to have_link 'Português'
    end
  end

  it 'and changes the language' do
    visit root_path
    within 'nav' do
      click_on 'Português'
    end

    expect(page).to have_content 'Carros'
    expect(page).not_to have_content 'Cars'
  end
end
