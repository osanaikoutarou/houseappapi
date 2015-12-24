class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :uuid
      t.string :image_url
      t.boolean :like
      t.boolean :pass
      t.integer :liked_num
      t.integer :passed_num
      t.text :description

      t.timestamps null: false
    end
  end
end
