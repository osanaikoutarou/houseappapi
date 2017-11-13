class UserProfile < ApplicationRecord

  belongs_to :user

  include Swagger::Blocks

  swagger_schema :UserProfile do
    key :required, [:id]
    property :id, type: :string, description: 'Unique UUID'
    property :first_name, type: :string
    property :last_name, type: :string
    property :first_name_kana, type: :string
    property :last_name_kana, type: :string
    property :gender, type: :string, description: '0: unknown, 1: male, 2: female'
    property :zip_code, type: :string
    property :prefecture, type: :string
    property :city, type: :string
    property :address1, type: :string
    property :address2, type: :string
    property :latitude, type: :string
    property :longitude, type: :string
    
    property :displayed_tutorial, type: :bool
    property :gender, type: :int
    property :year_of_birth, type: :int
    property :want_to_live_pref_name, type: :string
    property :have_own_land, type: :bool
    property :user_states_for_architect, type: :string
    property :price_policy, type: :string
    property :resident_num, type: :int
    property :child_num, type: :int
    property :elderly_num, type: :int
    property :pet_dog, type: :string
    property :pet_cat, type: :string
    property :pet_other, type: :string
    property :nickname, type: :string
    property :contents_of_request do
      key :type, :array
      items do
        key :type, :string
      end
    end
  end
end
