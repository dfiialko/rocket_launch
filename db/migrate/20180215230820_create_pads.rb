class CreatePads < ActiveRecord::Migration[5.1]
  def change
    create_table :pads do |t|

      t.timestamps
    end
  end
end
