class CreateFavoriteArchitects < ActiveRecord::Migration
  def change
    create_table :favorite_architects do |t|
      t.references :user, null: false
      t.references :architect, null: false
      t.boolean :like

      t.timestamps
    end
  end
end
