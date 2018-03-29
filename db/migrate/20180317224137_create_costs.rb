class CreateCosts < ActiveRecord::Migration[5.1]
  def change
    create_table :costs do |t|
      t.string :name, length: 300
      t.string :unit, null: false
      t.integer :quantity, null: false
      t.decimal :unit_price, null: false
      t.decimal :tax
      t.string :cost_type
      t.references :user, index: true, foreign_key: true
      t.references :invoice, index: true, foreign_key: true
      t.timestamps
    end
  end
end
