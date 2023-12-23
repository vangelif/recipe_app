class FoodsController < ApplicationController
  def index
    # @foods = current_user.foods
    @foods = Food.all
  end

  def new
    redirect_to foods_path, flash: { alert: 'Please sign up or login!' } unless current_user

    @food = Food.new
  end

  def create
    @new_food = current_user.foods.new(food_params)
    if @new_food.save
      redirect_to foods_path, flash: { notice: 'Your food is added successfully' }
    else
      redirect_to new_food_path, flash: { alert: 'Could not save your food' }
    end
  end

  def destroy
    food = Food.find(params[:id])

    unless food.user == current_user
      flash[:alert] =
        'You do not have access to delete the Food belongs to other Users.'
    end

    if food.destroy
      flash[:notice] = 'Food was successfully deleted.'
    else
      flash[:alert] = 'Food deleting Failed. Please try again.'
    end
    redirect_back(fallback_location: root_path)
  end

  def general
    @foods = current_user.foods
    current_user.recipes.map do |recipe|
      recipe.ingredients.includes(:food).map do |ingredient|
        food = ingredient.food
        test = @foods.select { |f| f.name == food.name }[0]
        test.quantity = test.quantity - ingredient.quantity
      end
    end
    @foods = @foods.select { |f| f.quantity.negative? }
    @foods.each { |f| f.quantity *= -1 }
    @total = 0
    @foods.each do |food|
      @total += (food.price * food.quantity)
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :quantity, :measurement_unit, :price)
  end
end
