class AlterHouseAreaDataType < ActiveRecord::Migration[5.0]
  def change
    change_column :houses, :floor_space, :decimal
    change_column :houses, :site_area_space, :decimal
  end
end
