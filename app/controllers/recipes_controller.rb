class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create edit update destroy]

  # root page, /recipes
  def index
    # added .includes(:author) to avoid N+1 queries
    @recipes = current_user.recipes.includes(:author)
  end

  # ../recipes/1
  def show
    recipe_test = Recipe.find(params[:id])
    unless recipe_test.author == current_user || recipe_test.public?
      flash[:alert] =
        'You do not have access to see details.'
      return redirect_to recipes_path
    end

    @recipe = Recipe.find(params[:id])
    @ingredients = Ingredient.where(recipe_id: @recipe.id).includes(:food, :recipe)
  end

  # ../recipes/new
  def new
    @recipe = Recipe.new
  end

  # ../recipes (POST)
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.author = current_user
    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe was successfully created.'
    else
      puts @recipe.errors.full_messages
      render :new
    end
  end

  # ../recipes/1/edit
  def edit; end

  # ../recipes/1 (PATCH/PUT)
  def update
  @recipe = Recipe.find(params[:id])
  puts "Updating recipe with params: #{recipe_params}"
  if @recipe.author != current_user
    flash[:alert] = 'You do not have access to edit this recipe.'
    return redirect_to recipes_path 
  end

  @recipe.update(recipe_params)
  if @recipe.errors.empty?
    puts "Recipe updated successfully."
    redirect_to recipes_path(@recipe), notice: 'Recipe was successfully updated.'
  else
    puts @recipe.errors.full_messages
    render :edit
    end
  end
  # ../recipes/1 (DELETE)
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe was successfully deleted.'
  end

  def public_recipes
    # added .includes(:author) to avoid N+1 queries
    @public_recipes = Recipe.includes(:author).where(public: true).order(created_at: :desc)
  end

  def generate_shopping_list
    redirect_to shopping_list_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public)
  end
end
