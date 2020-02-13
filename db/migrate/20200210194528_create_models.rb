class CreateModels < ActiveRecord::Migration[5.2]
  def change
    create_table :models do |t|
      t.string :stock_name
      t.integer :model_type

      t.timestamps
    end
  end
  
end
