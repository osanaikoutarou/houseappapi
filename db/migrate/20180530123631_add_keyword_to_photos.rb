class AddKeywordToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :keyword, :text
  end
end
