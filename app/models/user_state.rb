class UserState < ApplicationRecord

  belongs_to :user

  include Swagger::Blocks

  swagger_schema :UserState do
    key :required, [:id]
    property :id, type: :string, description: 'Unique UUID'
    
    property :displayed_tutorial, type: :bool
    property :gender, type: :int
    property :year_of_birth, type: :int
    property :want_to_live_pref_name, type: :string
    property :have_own_land, type: :bool
    property :user_states_for_architect, type: :string
    property :contents_of_request, type: :string
    property :price_policy, type: :string
    property :resident_num, type: :int
    property :child_num, type: :int
    property :elderly_num, type: :int
    property :pet_dog, type: :string
    property :pet_cat, type: :string
    property :pet_other, type: :string
        
  end
end
