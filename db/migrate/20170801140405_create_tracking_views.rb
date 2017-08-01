class CreateTrackingViews < ActiveRecord::Migration[5.0]
  def change
    create_table :architect_views, id: :uuid do |t|
      t.references :architect, index: true
      t.references :user
      t.references :anonymous_user

      t.timestamps
    end

    create_table :house_views, id: :uuid do |t|
      t.references :architect, index: true
      t.references :user
      t.references :anonymous_user

      t.timestamps
    end

    create_table :photo_views, id: :uuid do |t|
      t.references :photo, index: true
      t.references :user
      t.references :anonymous_user

      t.timestamps
    end
  end
end
