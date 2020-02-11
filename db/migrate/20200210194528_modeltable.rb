class Modeltable < ActiveRecord::Migration[5.2]
  def change
    create_table :model do |t|
      t.string :user_id
      t.string :stock_name
      t.integer :model_type
    end
  end
end
