class CreateInvites < ActiveRecord::Migration
  def change
    create_table :cakes do |t|
      t.string :name
      t.string :person_from_id
      t.string :person_to_id
    end
  end
end
