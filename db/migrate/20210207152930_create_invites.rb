class CreateInvites < ActiveRecord::Migration
  def change
    create_table "invites" do |t|
      t.string  "message"
      t.integer "receiver_id"
      t.integer "giver_id"
    end
  end
end
