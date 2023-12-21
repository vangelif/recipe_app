class Recipe < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :foods, through: :ingredients
  has_many :ingredients

  validates :name, :preparation_time, :cooking_time, presence: true
  # validates :name, uniqueness: true
  validates :preparation_time, :cooking_time, numericality: { only_integer: true }

  def self.public_recipes
    joins(:author, :foods)
      .select('recipes.id, recipes.name AS recipe_name, users.name AS user_name, users.email AS user_email, COUNT(foods.id) AS total_food_items, SUM(foods.price) AS total_food_price')
      .where(public: true)
      .group('recipes.id, author.id')
      .order('recipes.id')
  end
end
