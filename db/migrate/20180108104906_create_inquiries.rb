class CreateInquiries < ActiveRecord::Migration[5.0]
  def change
    create_table :inquiries, id: :uuid do |t|

      t.references :architect, null: false

      t.string :approach_type
      t.string :first_name
      t.string :last_name
      t.string :first_name_kana
      t.string :last_name_kana

      t.integer :year_of_birth
      t.string :gender

      t.string :living_pref_name
      t.string :want_to_pref_name
      t.string :prefer_contact_method

      t.string :email
      t.string :phone_number
      t.text :message

      t.timestamps
    end
  end
end
