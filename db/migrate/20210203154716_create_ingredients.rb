class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :person_from_id
      t.integer :person_to_id
    end
  end
end
