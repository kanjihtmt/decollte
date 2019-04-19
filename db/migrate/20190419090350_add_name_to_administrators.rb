class AddNameToAdministrators < ActiveRecord::Migration[5.2]
  def change
    add_column :administrators, :username, :string, after: :id
    remove_column :administrators, :email
  end
end
