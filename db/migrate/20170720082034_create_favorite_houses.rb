class CreateFavoriteHouses < ActiveRecord::Migration
  def change
    create_table :favorite_houses do |t|
      t.references :user, null: false
      t.references :house, null: false
      t.boolean :like

      t.timestamps
    end
  end
end
