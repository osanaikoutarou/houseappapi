class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.references :architect
      t.string :name              # house名
      t.text :description         # 説明
      t.integer :cost_type
      t.integer :floor_space
      t.integer :site_area_space
      t.string :zip_code
      t.string :prefecture
      t.string :city
      t.string :address1
      t.string :address2
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6

      t.timestamps null: false
    end

    add_index :houses, [:created_at]
  end
end
