class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :country_name, null: false
      t.string :iso_code, unique: true, null: false, index: true
      t.boolean :active, null: false, default: true
    end
  end
end
