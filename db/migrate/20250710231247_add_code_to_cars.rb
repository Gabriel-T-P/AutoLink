class AddCodeToCars < ActiveRecord::Migration[8.0]
  def change
    add_column :cars, :code, :string, null: false
  end
end
