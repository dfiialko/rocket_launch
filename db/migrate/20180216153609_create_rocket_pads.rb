class CreateRocketPads < ActiveRecord::Migration[5.1]
  def change
    create_table :rocket_pads do |t|

      t.timestamps
    end
  end
end
