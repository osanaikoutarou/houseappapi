class AddArchitectProfileData < ActiveRecord::Migration[5.0]
  def change

    add_column :architects, :year_of_birth, :integer
    add_column :architects, :gender, :integer
    add_column :architects, :hometown, :string

  end
end
