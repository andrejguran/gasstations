class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :station, index: true
      t.string :fuel
      t.decimal :price
      t.date :added

      t.timestamps
    end
  end
end
