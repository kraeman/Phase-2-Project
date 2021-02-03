class CreateCakeIngredients < ActiveRecord::Migration
  def change
    create_table :cake_ingredients do |t|
      t.integer :cake_id
      t.integer :ingredient_id
    end
  end
end
