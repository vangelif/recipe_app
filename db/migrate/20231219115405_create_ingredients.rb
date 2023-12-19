class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.integer :quantity
      t.references :recipe, null: false, foreign_key: { to_table: :recipes }
      t.references :food, null: false, foreign_key: { to_table: :foods }
      t.timestamps
    end
  end
end
