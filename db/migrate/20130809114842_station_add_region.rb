class StationAddRegion < ActiveRecord::Migration
  def change
    add_column :stations, :region, :string
  end
end
