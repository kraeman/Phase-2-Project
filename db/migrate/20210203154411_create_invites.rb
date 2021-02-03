class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :message
      t.string :person_from_id
      t.string :person_to_id
    end
  end
end
