class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :name, null: false, uniqe: true, index: true
      t.boolean :active, default: true, null: false
    end
  end
end
