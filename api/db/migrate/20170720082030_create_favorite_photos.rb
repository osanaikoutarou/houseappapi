class CreateFavoritePhotos < ActiveRecord::Migration
  def change
    create_table :favorite_photos do |t|
      t.references :photo
      t.references :user
      t.boolean :like

      t.timestamps
    end
  end
end
