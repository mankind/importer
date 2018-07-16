class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.date :date
      t.string :uuid,  null: false
      t.string :publisher_name
      t.string :csv_name, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :books, :csv_name
    add_index :books, :uuid, unique: true
  end
end
