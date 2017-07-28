class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.references :user
      t.text :first_name
      t.text :last_name
      t.text :first_name_kana
      t.text :last_name_kana
      t.string :gender
      t.string :postal_code
      t.string :prefecture
      t.text :city
      t.text :address1
      t.text :address2

      t.timestamps null: true
    end
  end
end
