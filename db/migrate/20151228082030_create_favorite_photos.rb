class CreateFavoritePhotos < ActiveRecord::Migration
  def change
    create_table :favorite_photos do |t|
      t.string :user_uuid
      t.string :photo_uuid
      t.boolean :like
      t.boolean :pass
      
      t.timestamps null: false
      
      t.references :photo
      t.references :user
      
    end
  end
end
