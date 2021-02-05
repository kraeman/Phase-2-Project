class CreateCakes < ActiveRecord::Migration
  def change
    create_table :cakes do |t|
      t.string :name
      t.string :recipe
      t.decimal :cook_time
      t.references :receiver, references: :users, foreign_key: { to_table: :users }
      t.references :giver, references: :users, foreign_key: { to_table: :users}
    end
  end
end
