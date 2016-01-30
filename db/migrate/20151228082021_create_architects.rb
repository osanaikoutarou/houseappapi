class CreateArchitects < ActiveRecord::Migration
  def change
    create_table :architects do |t|
      t.string :uuid
      t.integer :liked_count
      t.text :icon_url
      t.text :name
      t.text :description
      
      t.references :house
      t.references :photo
      t.references :favorite_architect

      t.timestamps null: false
    end
    
    add_index :architects, [:house_id, :photo_id, :created_at]
  end
end
