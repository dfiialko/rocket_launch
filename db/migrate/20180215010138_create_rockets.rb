class CreateRockets < ActiveRecord::Migration[5.1]
  def change
    create_table :rockets do |t|
      t.string :name
      t.string :wiki
      t.string :info
      t.string :img
      t.integer :agency_id
      t.integer :defaultPad
      t.timestamps
    end
  end
end
