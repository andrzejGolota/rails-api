class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.references :user, index: true, foreign_key: true
      t.references :contact_user, index: true
      t.string :first_name
      t.string :last_name
      t.references :company, index: true
      t.boolean :accepted, default: false
      t.timestamps
    end
  end
end
