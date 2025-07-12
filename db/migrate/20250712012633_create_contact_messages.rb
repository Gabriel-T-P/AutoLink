class CreateContactMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :contact_messages do |t|
      t.string :name,           null: false
      t.string :phone_number,   null: false
      t.string :message,        null: false
      t.references :seller,     null: false, foreign_key: true

      t.timestamps
    end
  end
end
