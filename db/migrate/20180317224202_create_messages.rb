class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :user, index: true, foreign_key: true
      t.references :recipent, index: true
      t.string :content, length: 4000
      t.string :state, null: false
      t.string :attachment
      t.datetime :received_at
      t.timestamps
    end
    add_foreign_key :messages, :users, column: :recipent_id
  end
end
