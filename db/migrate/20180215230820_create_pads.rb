class CreatePads < ActiveRecord::Migration[5.1]
  def change
    create_table :pads do |t|
      t.integer :pad_id
      t.string :name
      t.string :map
      t.string :agency
      t.string :info
      t.string :wiki
      t.timestamps
    end
  end
end
