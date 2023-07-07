class AddIdToFoodRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :foods_recipes, :id, :primary_key
    add_index :foods_recipes, [:food_id, :recipe_id], unique: true
  end
end
