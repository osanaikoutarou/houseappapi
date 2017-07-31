class CreateArchitects < ActiveRecord::Migration
  def change
    create_table :architects do |t|
      t.text :name                # architect name
      t.text :description         # メッセージ？
      t.text :avatar              # profile image
      t.text :policy              # こだわり、ポリシー
      t.text :affiliation         # 所属
      t.text :qualifications      # 資格
      t.text :speciality          # 得意タイプ
      t.text :career              # 経歴
      t.text :homepage_url        # ホームページURL

      # 住所は後回し

      t.timestamps null: true
    end

    add_index :architects, [:created_at]
  end
end
