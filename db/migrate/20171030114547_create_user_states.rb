class CreateUserStates < ActiveRecord::Migration[5.0]
  def change
    create_table :user_states do |t|
      t.references :user
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
