class CreateSellers < ActiveRecord::Migration[8.0]
  def change
    create_table :sellers do |t|
      t.string :name,           null: false
      t.string :phone_number,   null: false

      t.timestamps
    end
  end
end
