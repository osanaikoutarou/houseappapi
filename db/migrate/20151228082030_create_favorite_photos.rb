class CreateFavoritePhotos < ActiveRecord::Migration
  def change
    create_table :favorite_photos do |t|
      t.string :user_uuid
      t.string :photo_uuid
      t.boolean :like
      t.boolean :pass
      t.integer :photo_id
      
      t.belongs_to :photo

      t.timestamps null: false
    end
  end
end
