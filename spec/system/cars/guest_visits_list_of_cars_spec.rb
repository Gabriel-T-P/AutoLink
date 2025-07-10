require 'rails_helper'

describe 'Guest visits page thats list all cars', type: :system do
  it 'as root path' do
    visit root_path

    expect(page).to have_content 'Test Name'
  end
end
