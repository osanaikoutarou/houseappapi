class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.references :architect
      t.text :title             # house名
      t.text :short_description # 説明
      t.text :description
      t.integer :cost_type
      t.integer :floor_space
      t.integer :site_area_space
      t.string :zip_code
      t.string :prefecture
      t.string :city
      t.string :address1
      t.string :address2

      t.timestamps null: false
    end

    add_index :houses, [:created_at]
  end
end
