class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.references :user
      t.string :first_name
      t.string :last_name
      t.string :first_name_kana
      t.string :last_name_kana
      t.string :gender
      t.string :zip_code
      t.string :prefecture
      t.string :city
      t.string :address1
      t.string :address2
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      
      t.boolean :displayed_tutorial
      t.integer :year_of_birth
      t.string :want_to_live_pref_name
      t.boolean :have_own_land
      t.string :user_states_for_architect
      t.string :contents_of_request
      t.string :price_policy
      t.string :resident_num
      t.string :child_num
      t.string :elderly_num
      t.string :pet_dog
      t.string :pet_cat
      t.string :pet_other

      t.timestamps null: false
    end
  end
end
