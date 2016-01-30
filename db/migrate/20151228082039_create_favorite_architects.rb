class CreateFavoriteArchitects < ActiveRecord::Migration
  def change
    create_table :favorite_architects do |t|
      t.boolean :like
      t.boolean :dislike
      
      t.belongs_to :user
      t.belongs_to :architect

      t.timestamps null: false
    end
  end
end
