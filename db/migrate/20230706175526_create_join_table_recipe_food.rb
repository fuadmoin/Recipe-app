class CreateJoinTableRecipeFood < ActiveRecord::Migration[7.0]
  def change
    create_join_table :recipes, :foods do |t|
      t.float :quantity
      t.index [:food_id, :recipe_id]
      t.index [:recipe_id, :food_id]
    end

    add_column :foods_recipes, :id, :primary_key
    remove_index :foods_recipes, column: [:food_id, :recipe_id]
    add_index :foods_recipes, [:food_id, :recipe_id], unique: true
  end
end