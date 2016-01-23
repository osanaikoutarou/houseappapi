class CreateFavoriteHouses < ActiveRecord::Migration
  def change
    create_table :favorite_houses do |t|
      t.string :user_uuid
      t.string :house_uuid
      t.boolean :like
      t.boolean :dislike

      t.integer :user_id

      t.timestamps null: false
    end
  end
end
