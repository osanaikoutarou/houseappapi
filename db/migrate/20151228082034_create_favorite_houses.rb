class CreateFavoriteHouses < ActiveRecord::Migration
  def change
    create_table :favorite_houses do |t|
      t.string :user_uuid
      t.string :house_uuid
      t.boolean :like
      t.boolean :dislike

			t.belongs_to :house
			t.belongs_to :user
      
      t.timestamps null: false
    end
  end
end
