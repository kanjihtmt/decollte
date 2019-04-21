class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.references :brand
      t.string :name, null: false
      t.timestamps
    end
  end
end