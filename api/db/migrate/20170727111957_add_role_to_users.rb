class AddRoleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :integer, default: 0 # role: 0: anonymous-user, 10: registered user, 11: architect
    add_reference :architects, :user, type: :uuid
  end
end
