class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.references :architect
      t.text :title             # house名
      t.text :description       # 説明
      t.text :cost              # 値段
      t.text :space             # 延べ床面積
      t.string :zip_code
      t.string :prefecture
      t.string :city
      t.string :address1
      t.string :address2

      t.timestamps null: true
    end

    add_index :houses, [:created_at]
  end
end
