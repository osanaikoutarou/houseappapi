class CreateHouseArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :house_articles, id: :uuid do |t|
      t.references :house, index: true
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
