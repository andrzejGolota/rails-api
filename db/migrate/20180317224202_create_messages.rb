class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :user, index: true, foreign_key: true
      t.references :recipent, index: true, foreign_key: { to_table: :user }
      t.string :content, length: 4000
      t.string :state, null: false
      t.string :attachment
      t.timestamps
    end
  end
end
