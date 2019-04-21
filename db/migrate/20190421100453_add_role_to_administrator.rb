class AddRoleToAdministrator < ActiveRecord::Migration[5.2]
  def change
    add_column :administrators, :role, :integer, default: 0, null: false
  end
end
