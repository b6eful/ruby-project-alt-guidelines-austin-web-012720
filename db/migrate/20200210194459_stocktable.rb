class Stocktable < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.integer :stock_id 
      t.float :open
      t.float :close
      t.float :high
      t.float :low
      t.string :stock_name
      t.datetime :date_time_searched
    end
  end
end
