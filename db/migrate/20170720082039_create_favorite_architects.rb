class CreateFavoriteArchitects < ActiveRecord::Migration
  def change
    create_table :favorite_architects do |t|
      t.references :architect
      t.references :user
      t.boolean :like

      t.timestamps
    end
  end
end
