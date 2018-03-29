class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.string :state
      t.timestamps
    end
  end
end
