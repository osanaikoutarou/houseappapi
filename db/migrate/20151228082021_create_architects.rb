class CreateArchitects < ActiveRecord::Migration
  def change
    create_table :architects do |t|
      t.string :uuid              # architect ID
      t.integer :liked_count
      t.text :icon_url            # icon file name
      t.text :name                # architect name
      t.text :description         # メッセージ？
      t.text :policy              # こだわり、ポリシー
      t.text :affiliation         # 所属
      t.text :qualifications      # 資格
      t.text :goodAtType          # 得意タイプ
      t.text :career              # 経歴
      t.text :homepage_url        # ホームページURL
      
      # 住所は後回し       
      
      t.references :favorite_architect
    
      t.timestamps null: false
    end
    
    add_index :architects, [:created_at]
  end
end