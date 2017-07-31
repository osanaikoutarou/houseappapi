class CreateFavoriteHouses < ActiveRecord::Migration
  def change
    create_table :favorite_houses do |t|
      t.references :house
      t.references :user
      t.boolean :like

      t.timestamps
    end
  end
end
