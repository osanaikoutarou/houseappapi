class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :uuid
      t.integer :view_count
      t.integer :liked_count
      t.text :title
      t.text :description
      t.string :photo_uuid

      t.timestamps null: false
    end
  end
end
