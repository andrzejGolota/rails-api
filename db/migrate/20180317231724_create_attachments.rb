class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.string :file, null: false
      t.references :user, index: true, foreign_key: true
      t.references :invoice, index: true, foreign_key: true
      t.timestamps
    end
  end
end
