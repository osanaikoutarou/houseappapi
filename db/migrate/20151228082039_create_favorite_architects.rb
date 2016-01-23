class CreateFavoriteArchitects < ActiveRecord::Migration
  def change
    create_table :favorite_architects do |t|
      t.string :user_uuid
      t.string :house_uuid
      t.boolean :like
      t.boolean :dislike
      
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
