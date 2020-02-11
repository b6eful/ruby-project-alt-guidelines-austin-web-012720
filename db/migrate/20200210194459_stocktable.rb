class Stocktable < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.integer :interval
      t.datetime :time_series
    end
  end
end
