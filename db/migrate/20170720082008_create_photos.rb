class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :house
      t.string :image
      t.string :title
      t.text :description
      t.boolean :featured_photo, default: false

      t.timestamps
    end

  end


end
