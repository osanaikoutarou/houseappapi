class CreateArchitects < ActiveRecord::Migration
  def change
    create_table :architects do |t|
      t.string :name
      t.text :introduction          # こだわり、ポリシー
      t.text :message
      t.string :avatar
      t.string :affiliation         # 所属
      t.string :speciality          # 得意タイプ
      t.text :qualifications        # 資格
      t.text :career                # 経歴
      t.string :homepage_url        # ホームページURL
      t.string :zip_code
      t.string :prefecture
      t.string :city
      t.string :address1
      t.string :address2
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6

      t.timestamps null: true
    end

    add_index :architects, [:created_at]
  end
end
