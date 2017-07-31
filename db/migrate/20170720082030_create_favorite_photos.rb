class CreateFavoritePhotos < ActiveRecord::Migration
  def change
    create_table :favorite_photos do |t|
      t.references :user, null: false
      t.references :photo, null: false
      t.boolean :like

      t.timestamps
    end
  end
end
