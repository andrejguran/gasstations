desc 'Takes arguments task'
task :task_name, :display_value, :display_times do |t, args|
  args.display_times.to_i.times do
    puts args.display_value
  end
end

task :feed, :cbid do |t, args|
  require 'rubygems'
  require 'nokogiri'  
  require 'open-uri'

  cbid = args.cbid || 6596
  page = Nokogiri::HTML(open("http://www.ceskybenzin.cz/historie-ceny-Natural-95-na-cerpaci-stanici/#{cbid}/-/"))   
  page.css('table.vypis1 tr').drop(1).each do |e| 
    e.css("td").each do |elem| 
      puts elem.text
    end
  end
end