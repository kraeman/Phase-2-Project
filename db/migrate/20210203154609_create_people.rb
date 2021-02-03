class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.boolean :bday
      t.integer :age
      t.string :birth_date
    end
  end
end
