require 'rails_helper'

RSpec.describe 'Foods', type: :system, js: true do
  describe 'index page' do
    before(:example) do
      @user = User.create(name: 'Rex', email: 'rex@mail.com', password: '123456')
      sign_in @user

      @food = Food.create(user: @user, name: 'Apple', measurement_unit: 'kg', quantity: 1, price: 10)
      visit foods_path
    end

    it 'renders name of food' do
      expect(page).to have_content(@food.name)
    end

    it 'renders measurement_unit of the food' do
      expect(page).to have_content(@food.measurement_unit)
    end

    it 'renders price of the food' do
      expect(page).to have_content(@food.price)
    end

    it 'redirects to delete path' do
      click_button 'Delete'
      expect(page).to have_current_path(foods_path)
    end

    it 'renders a button to add food' do
      expect(page).to have_content('Add Food')
    end

    it 'redirects to a form for new food' do
      click_link 'Add Food'
      expect(page).to have_current_path(new_food_path)
    end
  end
end
