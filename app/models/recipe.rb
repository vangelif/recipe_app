class Recipe < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :ingredients
  has_many :foods, through: :ingredients

  validates :name, :preparation_time, :cooking_time, presence: true
  # validates :name, uniqueness: true
  validates :preparation_time, :cooking_time, numericality: { only_integer: true }

  def self.public_recipes
    joins(:author, :foods)
      .select('recipes.id, recipes.name, users.name, COUNT(foods.id), SUM(foods.price)')
      .where(public: true)
      .group('recipes.id, author.id')
      .order('recipes.id')
  end
end
