class CreateModels < ActiveRecord::Migration[5.2]
  def change
    create_table :models do |t|
      t.string :name
      t.string :val
      t.string :file_path
      t.belongs_to :user

      t.timestamps
    end
  end

end
