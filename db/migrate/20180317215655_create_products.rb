class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.boolean :active, null: false, default: true
      t.decimal :price, null: false
      t.decimal :duration
      t.timestamps
    end
  end
end
