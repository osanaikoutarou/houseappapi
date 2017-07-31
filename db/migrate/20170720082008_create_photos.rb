class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :architect
      t.references :house
      t.string :image
      t.string :title
      t.text :description

      t.timestamps
    end
  end


end
