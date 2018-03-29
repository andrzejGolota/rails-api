class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name, null: false, length: 500
      t.string :company_number, null: false, length: 30, index: true
      t.string :vat_number, length: 30, null: false, index: true
      t.string :street, null: false
      t.string :postcode, null: false
      t.string :city, null: false
      t.string :region
      t.string :country_code, index: true, null: false
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
