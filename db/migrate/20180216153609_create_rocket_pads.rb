class CreateRocketPads < ActiveRecord::Migration[5.1]
  def change
    create_table :rocket_pads do |t|
      t.references :rocket,foreign_key:true
      t.references :pad,foreign_key:true
      t.timestamps
    end
  end
end
