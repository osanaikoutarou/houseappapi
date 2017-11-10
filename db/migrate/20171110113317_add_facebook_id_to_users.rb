class AddFacebookIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :facebook_id, :string
    add_column :users, :facebook_access_token, :string
    add_index :users, :facebook_id
  end
end
