class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uuid
      t.text :name_sei
      t.text :name_mei
      t.text :name_sei_kana
      t.text :name_mei_kana
      t.string :gender
      t.string :postal_code
      t.string :prefecture
      t.text :city
      t.text :address1
      t.text :address2
      
      t.references :favorite_photo
      t.references :favorite_house
      t.references :favorite_architect

      t.timestamps null: false
    end
  end
end
