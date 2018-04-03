class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true
      t.string :state, null: false
      t.decimal :amount, null: false
      t.string :paypal_id, index: true
      t.timestamps
    end
  end
end
