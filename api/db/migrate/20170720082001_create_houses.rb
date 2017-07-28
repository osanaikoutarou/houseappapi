class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.references :architect
      t.text :title             # house名
      t.text :description       # 説明
      t.text :cost              # 値段
      t.text :area              # 地域
      t.text :space             # 延べ床面積

      t.timestamps null: true
    end

    add_index :houses, [:created_at]
  end
end
