class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.references :user, index: true, foreign_key: true
      t.references :client, index: true
      t.string :invoice_number
      t.string :subject
      t.references :company, index: true, foreign_key: true
      t.string :state, null: false
      t.string :comment, length: 4000
      t.timestamps
    end
  end
end
