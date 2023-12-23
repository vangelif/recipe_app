require 'rails_helper'

RSpec.describe 'Foods#index', type: :system do
  before(:all) do
    Ingredient.destroy_all
    Food.destroy_all
    Recipe.destroy_all

    @food = Food.create(name: 'Apple', measurement_unit: 'kg', quantity: 1, price: 10)
  end

  it 'renders add food button' do
    visit foods_path
    expect(page).to have_content('Add Food')
  end

  it 'renders measurement of the food' do
    visit foods_path
    expect(page).to have_content('Measurement Unit')
  end

  it 'renders price of the food' do
    visit foods_path
    expect(page).to have_content('Price')
  end

  it 'redirects to a form for new food' do
    visit '/foods/new'
    click_link 'Add Food'
    sleep(1)
    expect(page).to have_current_path('/foods')
  end
end
