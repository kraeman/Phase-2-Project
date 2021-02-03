class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :name
      t.decimal :price
      t.integer :person_from_id
      t.integer :person_to_id
    end
  end
end
