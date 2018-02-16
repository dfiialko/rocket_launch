class CreateMissions < ActiveRecord::Migration[5.1]
  def change
    create_table :missions do |t|
      t.integer :agency_id
      t.string :name
      t.text :description
      t.integer :agency
      t.string :wiki
      t.timestamps
    end
  end
end
