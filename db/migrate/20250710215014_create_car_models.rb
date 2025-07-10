class CreateCarModels < ActiveRecord::Migration[8.0]
  def change
    create_table :car_models do |t|
      t.string :brand,          null: false
      t.string :name,           null: false
      t.string :car_category,   null: false
      t.date :year,             null: false
      t.integer :fuel_type,     null: false
      t.integer :transmission,  null: false
      t.string :engine,         null: false
      t.integer :doors_number,  null: false

      t.timestamps
    end
  end
end
