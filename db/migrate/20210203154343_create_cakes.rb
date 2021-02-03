class CreateCakes < ActiveRecord::Migration
  def change
    create_table :cakes do |t|
      t.string :name
      t.decimal :price
      t.decimal :cook_time
      t.integer :ingredient_id
    end
  end
end
