class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :uuid
      t.text :title
      t.string :image_url
      t.integer :liked_count
      t.integer :passed_count
      t.text :description
      
      t.references :architect
      t.references :house
      t.references :favorite_photo

      t.timestamps null: false
    end
    
  end
end
