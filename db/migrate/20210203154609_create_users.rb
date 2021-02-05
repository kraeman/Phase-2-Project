class CreateUsers < ActiveRecord::Migration
  def change
    create_table :user do |t|
      t.string :name
      t.boolean :bday
      t.integer :age
      t.string :birth_date
    end
  end
end
