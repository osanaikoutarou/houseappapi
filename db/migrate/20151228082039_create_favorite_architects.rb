class CreateFavoriteArchitects < ActiveRecord::Migration
  def change
    create_table :favorite_architects do |t|
      t.boolean :like
      t.boolean :dislike
      
      t.timestamps null: false
      
      t.references :architect
      t.references :user
      
    end
  end
end
