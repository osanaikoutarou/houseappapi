class AddEmailToArchitecs < ActiveRecord::Migration[5.0]
  def change
    add_column :architects, :email, :string
  end
end
