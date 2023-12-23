require 'rails_helper'

RSpec.describe 'Recipes#index', type: :system do
    before(:all) do
        Ingredient.destroy_all
        Food.destroy_all
        Recipe.destroy_all

        @recipe = Recipe.create(name: 'Recipe App', description: 'My Recipes', )
        
    end

    it 'displays the name of recipes' do
        visit recipes_path
        expect(page).to have_content(@recipe.name)
    end
    it 'displays the description of recipes' do
        visit recipes_path
        expect(page).to have_content(@recipe.description)
    end
    it 'displays the add recipe action' do
        visit recipes_path
        expect(page).to have_content('Add Recipe')
    end
    it 'displays the public recipes' do
        visit recipes_path
        expect(page).to have_content('Public Recipe')
    end
end