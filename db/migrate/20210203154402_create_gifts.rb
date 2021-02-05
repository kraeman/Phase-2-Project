class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :name
      t.decimal :price
      t.references :receiver, references: :users, foreign_key: { to_table: :users }
      t.references :giver, references: :users, foreign_key: { to_table: :users}
    end
  end
end
