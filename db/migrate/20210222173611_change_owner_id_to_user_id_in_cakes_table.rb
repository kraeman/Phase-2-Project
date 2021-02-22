class ChangeOwnerIdToUserIdInCakesTable < ActiveRecord::Migration
  def change
    rename_column :cakes, :owner_id, :user_id
  end
end
