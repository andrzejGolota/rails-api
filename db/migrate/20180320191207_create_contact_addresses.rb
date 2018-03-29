class CreateContactAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_addresses do |t|
      t.references :contact, index: true, foreign_key: true
      t.string :phone_number
      t.string :email
      t.string :street
      t.string :postcode
      t.string :city
      t.boolean :default, null: false, default: false
      t.timestamps
    end
  end
end
