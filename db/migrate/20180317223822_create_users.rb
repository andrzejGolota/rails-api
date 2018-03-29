class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :uid, index: true
      t.string :first_name, length: 255, null: false
      t.string :last_name, length: 255, null: false
      t.string :email, length: 30, index: true, unique: true
      t.string :login, length: 20, unique: true, index: true
      t.string :password_digest
      t.boolean :is_active, null: false, default: false
      t.datetime :activation_sent_date, null: false
      t.datetime :activated_at
      t.string :activation_digest
      t.string :remember_digest
      t.string :reset_digest
      t.datetime :reset_sent_date
      t.string :provider
      t.string :avatar    
      t.boolean :contact_visibility, null: false, default: true
      t.references :role, index: true, foreign_key: true
      t.timestamps
    end
  end
end
