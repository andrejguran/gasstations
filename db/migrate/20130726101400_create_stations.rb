class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer :cbid
      t.string :name
      t.string :city
      t.string :address
      t.decimal :latitude
      t.decimal :longtitude

      t.timestamps
    end
  end
end
