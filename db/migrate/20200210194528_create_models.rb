class CreateModels < ActiveRecord::Migration[5.2]
  def change
    create_table :models do |t|
      t.string :name
      t.string :val
      t.belongs_to :user

      t.timestamps
    end
  end

end
