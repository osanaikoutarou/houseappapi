class CreateAnonymousUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :anonymous_users, id: :uuid do |t|
      t.references :user, null: true
      t.json :preferences
      t.string :device_name
      t.string :device_model
      t.string :device_idfv # iOS only (optional)
      t.string :device_idfa # iOS only (optional)
      t.string :device_gps_adid # Android only (optional)
      t.string :app_version

      t.timestamps null: false
    end
  end
end
