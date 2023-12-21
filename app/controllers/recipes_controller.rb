class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create edit update destroy]

  # root page, /recipes
  def index
    @recipes = current_user.recipes
  end

  # ../recipes/1
  def show
    @recipe = Recipe.find(params[:id])
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
  def update; end

  # ../recipes/1 (DELETE)
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe was successfully deleted.'
  end

  def public_recipes
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def generate_shopping_list
    redirect_to shopping_list_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public)
  end
end
