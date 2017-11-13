class AddUserProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :user_profiles, :displayed_tutorial, :boolean
    add_column :user_profiles, :year_of_birth, :integer
    add_column :user_profiles, :want_to_live_pref_name, :string
    add_column :user_profiles, :have_own_land, :boolean
    add_column :user_profiles, :user_states_for_architect, :string
    add_column :user_profiles, :price_policy, :string
    add_column :user_profiles, :resident_num, :string
    add_column :user_profiles, :child_num, :string
    add_column :user_profiles, :elderly_num, :string
    add_column :user_profiles, :pet_dog, :string
    add_column :user_profiles, :pet_cat, :string
    add_column :user_profiles, :pet_other, :string
    add_column :user_profiles, :nickname, :string
    add_column :user_profiles, :contents_of_request, :string, array: true, default: []
  end
end
