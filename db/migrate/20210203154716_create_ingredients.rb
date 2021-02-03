class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :cakes do |t|
      t.string :name
    end
  end
end
