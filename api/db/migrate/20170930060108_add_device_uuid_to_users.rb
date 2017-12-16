class AddDeviceUuidToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :device_uuid, :uuid
    add_index :users, :device_uuid
  end
end
