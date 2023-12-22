class IngredientsController < ApplicationController
    def new
      recipe = Recipe.find(params[:recipe_id])
      unless recipe.author == current_user
        flash[:alert] =
          'You do not have access to add an ingredient on a recipe that belongs to other Users.'
        return redirect_to recipes_path
      end
  
      @ingredient = Ingredient.new
      @foods = current_user.foods
    end
  
    def create
      @recipe = Recipe.find(params[:recipe_id])
      ingredient = Ingredient.new(ingredient_params)
      ingredient.recipe = @recipe
  
      if ingredient.save
        redirect_to recipe_path(@recipe), notice: 'New ingredient was successfully added.'
      else
        flash[:alert] = 'New Ingredient adding Failed. Please try again.'
      end
    end
  
    def destroy
      ingredient = Ingredient.find(params[:id])
  
      unless ingredient.recipe.author == current_user
        flash[:alert] =
          'You do not have access to delete the ingredient belongs to other Users.'
        return redirect_to recipes_path
      end
  
      if ingredient.destroy
        flash[:notice] = 'Ingredient was successfully removed.'
      else
        flash[:alert] = 'Ingredient removal Failed. Please try again.'
      end
      redirect_back(fallback_location: root_path)
    end
  
    private
  
    def ingredient_params
      params.require(:ingredient).permit(:quantity, :food_id)
    end
  end