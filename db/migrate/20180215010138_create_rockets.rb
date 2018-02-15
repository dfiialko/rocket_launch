class CreateRockets < ActiveRecord::Migration[5.1]
  def change
    create_table :rockets do |t|
      t.integer :id
      t.string :name
      t.string :wiki
      t.string :info
      t.string :img

      t.timestamps
    end
  end
end
