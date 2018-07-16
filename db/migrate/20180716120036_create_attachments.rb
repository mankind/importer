class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.string :csv_file,  null: false
      t.string :uuid,  null: false
      t.string :original_csv_filename
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :attachments, :uuid, unique: true
  end
end
