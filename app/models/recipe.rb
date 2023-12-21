class Recipe < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :foods, through: :ingredients
  has_many :ingredients

  validates :name, :preparation_time, :cooking_time, presence: true
  # validates :name, uniqueness: true
  validates :preparation_time, :cooking_time, numericality: { only_integer: true }
end
