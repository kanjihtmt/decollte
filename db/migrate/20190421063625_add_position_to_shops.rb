class AddPositionToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :position, :integer
  end
end
