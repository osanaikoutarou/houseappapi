class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :uuid              # photoID
      t.text :title               # title
      t.string :image_url         # image file name
      t.integer :liked_count
      t.integer :passed_count
      t.text :description         # 説明文
      
      # room type -> tag
      # room style -> tag
      
      t.references :architect
      t.references :house
      t.references :favorite_photo

      t.timestamps null: false
    end
    
  end
end
