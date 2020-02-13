class CreateStockModel < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_models do |t|
      t.belongs_to :stock
      t.belongs_to :model
    end
  end
end
