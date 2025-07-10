class CreateCars < ActiveRecord::Migration[8.0]
  def change
    create_table :cars do |t|
      t.references :car_model,      null: false, foreign_key: true
      t.string :color,              null: false
      t.string :license_plate,      null: false
      t.string :city,               null: false
      t.string :state,              null: false
      t.integer :mileage,           null: false
      t.integer :price,             null: false
      t.datetime :fabricated_at,    null: false

      t.timestamps
    end
  end
end
