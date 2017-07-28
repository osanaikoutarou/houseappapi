class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :architect
      t.references :house
      t.text :title               # title
      t.string :image_url         # image file name
      t.text :description         # 説明文
      t.string :photo_type        # 特殊タイプ(代表画像など) 基本は空
      t.integer :priority         # 優先度 基本は空か0 高いほど優先度が高い
      t.integer :liked_count
      t.integer :passed_count

      # room type -> tag
      # room style -> tag
      t.timestamps
    end
  end


end
