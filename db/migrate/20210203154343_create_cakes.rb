class CreateCakes < ActiveRecord::Migration
  def change
    create_table :cakes do |t|
      t.string :name
      t.string :recipe
      t.decimal :cook_time
    end
  end
end
