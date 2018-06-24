class AlterLikesTableName < ActiveRecord::Migration[5.0]
  def change
    rename_table :favorite_architects, :architect_likes
    rename_table :favorite_photos, :photo_likes
    rename_table :favorite_houses, :house_likes
  end
end
