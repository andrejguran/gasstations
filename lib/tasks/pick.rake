desc 'Feeds everything'
task :feed => :environment do
  get_cbids.each do |cbid|
    add_station(cbid) unless station_exists?(cbid)
    feed_station(cbid)
  end
end

def feed_station(cbid)
  require 'rubygems'
  require 'nokogiri'  
  require 'open-uri'

  page = Nokogiri::HTML(open("http://www.ceskybenzin.cz/historie-ceny-Natural-95-na-cerpaci-stanici/#{cbid}/-/"))   
  page.css('table.vypis1 tr').drop(2).each do |e| 
    entry = parse_entry(e)
    add_entry(cbid, entry) unless entry_exists(cbid, entry)
  end
end

def parse_entry(e)
  element = Array.new
  e.css("td").each do |elem| 
    element.push elem.text
  end
  element
end

def entry_exists(cbid, entry)
  station = Station.find_by(cbid: cbid)
  !Entry.find_by(station_id: station.id, added: Date.parse(entry[0].strip), fuel: entry[4].strip, price: entry[5].to_d).nil?
end

def add_entry(cbid, entry)
  station = Station.find_by(cbid: cbid)
  Entry.create(station_id: station.id, added: entry[0], fuel: entry[4], price: entry[5].to_d)
end

def get_cbids
  require 'open-uri'
  url = 'http://www.ceskybenzin.cz/mapa/0'
  open(url).read.scan /'green', (\d), bublina/
end

def add_station(cbid)
  s = get_station_data(cbid)
  Station.create(cbid: cbid, name: s[0], city: s[1], address: s[2], latitude: s[4], longtitude: s[5], region: s[3])
end

def station_exists?(cbid)
  !Station.find_by(cbid: cbid).nil?
end

def get_station_data(cbid)
  url = 'http://www.ceskybenzin.cz/mapa/0'
  station = open(url).read.scan /var bublina = '(.*?)<br>(.*?)<br>(.*?)<br>(.*?)<br>.*?'green', #{cbid}, bublina.*?google\.maps\.LatLng\(([0-9]{2}\.[0-9]{0,10}), ([0-9]{2}\.[0-9]{0,10})\);/m
  station.flatten
end