class CreateAgencies < ActiveRecord::Migration[5.1]
  def change
    create_table :agencies do |t|
      t.integer :agency_id
      t.string :name
      t.string :abbrev
      t.string :countryCode
      t.integer :islsp
      t.timestamps
    end
  end
end
