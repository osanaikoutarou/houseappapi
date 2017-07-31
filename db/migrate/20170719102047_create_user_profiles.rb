class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.references :user
      t.text :first_name
      t.text :last_name
      t.text :first_name_kana
      t.text :last_name_kana
      t.string :gender
      t.string :zip_code
      t.string :prefecture
      t.string :city
      t.string :address1
      t.string :address2

      t.timestamps null: true
    end
  end
end
