class CreateJoinTableRecipeFood < ActiveRecord::Migration[7.0]
  def change
    create_join_table :recipes, :foods do |t|
      t.float :quantity
      t.index [:food_id, :recipe_id]
      t.index [:recipe_id, :food_id]
    end
  end
end