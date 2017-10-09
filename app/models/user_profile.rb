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
  end
end
