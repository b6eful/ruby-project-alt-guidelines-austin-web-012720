class Usertable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :user_id 
      t.string :user_name
      t.string :password
      t.string :stock_searched
    end
  end
end
