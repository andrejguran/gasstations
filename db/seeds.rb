# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

station = Station.create(
   cbid: "820", 
   name: "Agip", 
   city: "Praha 10", 
   address: "V Korytech",
   latitude: 50.0534, 
   longtitude: 14.5191
)

Entry.create(
  station_id: station.id,
  fuel: "Natural 95",
  price: 37.20,
  added: DateTime.new(2013, 7, 23)
)

Entry.create(
  station_id: station.id,
  fuel: "Natural 95",
  price: 37.40,
  added: DateTime.new(2013, 7, 26)
)