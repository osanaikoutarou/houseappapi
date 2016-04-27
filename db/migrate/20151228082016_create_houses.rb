class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :uuid            # houseID
      t.integer :view_count     # 閲覧数
      t.integer :liked_count
      t.text :title             # house名
      t.text :description       # 説明
      t.text :cost              # 値段
      t.text :area              # 地域
      t.text :space             # 延べ床面積

      t.references :architect
      t.references :favorite_house

      t.timestamps null: false
    end
    
    add_index :houses, [:created_at]
  end
  
end