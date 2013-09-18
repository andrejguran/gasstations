# encoding: UTF-8

desc 'Feeds everything'
task :feed => :environment do
  get_stations_data.each do |station|
    add_station(station) unless station_exists?(station[:cbid])
    feed_station(station[:cbid])
  end
end

def feed_station(cbid)
  require 'rubygems'
  require 'nokogiri'  
  require 'open-uri'

  page = Nokogiri::HTML(open("http://www.ceskybenzin.cz/historie-ceny-Natural-95-na-cerpaci-stanici/#{cbid}/-/"))   
  page.css('table.vypis1 tr').drop(2).each do |e| 
    entry = parse_entry(e)
    add_entry(cbid, entry) unless entry_exists?(cbid, entry)
  end
end

def parse_entry(elem)
  elems = elem.css('td')
  
  {
    added: DateTime.strptime(elems[0].text, '%d.%m.%Y'),
    fuel: elems[4].text.encode('UTF-8'),
    price: elems[5].text[0,4].gsub(',', '.').to_d,
  }
end

def station_exists?(cbid)
  !Station.find_by(cbid: cbid).nil?
end

def add_station(station)
  Station.create(station)
end

def entry_exists?(cbid, entry)
  !Station.find_by(cbid: cbid).entries.find_by(entry).nil?
end

def add_entry(cbid, entry)
  Station.find_by(cbid: cbid).entries.create(entry)
end

def get_stations_data
  require 'open-uri'
  url = 'http://www.ceskybenzin.cz/mapa/0'
  pattern = /var bublina = '(.*?)<br>(.*?)<br>(.*?)<br>(.*?)<br>.*?'green', (.*?), bublina, 0 \);.*?google\.maps\.LatLng\(([0-9]{2}\.[0-9]{0,10}), ([0-9]{2}\.[0-9]{0,10})\);/m
  data = open(url).read.force_encoding('Windows-1250').scan pattern
  
  stations = Array.new
  data.each do |s|
    station = {
      cbid: s[4].to_i,
      name: s[0].encode("utf-8"),
      city: s[1].encode("utf-8"),
      address: s[2].encode("utf-8"),
      region: s[3].encode("utf-8"),
      latitude: s[5].to_d,
      longtitude: s[6].to_d
    }

    stations.push station
  end

  stations[1..5]
end
