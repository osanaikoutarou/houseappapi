class CreateArchitects < ActiveRecord::Migration
  def change
    create_table :architects do |t|
      t.string :uuid
      t.integer :liked_count
      t.text :icon_url
      t.text :title
      t.text :description
      t.string :house_id

      t.timestamps null: false
    end
  end
end
