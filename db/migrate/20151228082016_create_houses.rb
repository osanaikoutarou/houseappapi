class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :uuid
      t.integer :view_count
      t.integer :liked_count
      t.text :title
      t.text :description

      t.references :photo
      t.belongs_to :architect
      t.references :favorite_house

      t.timestamps null: false
    end
    
    add_index :houses, [:photo_id, :created_at]
  end
end
