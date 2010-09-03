#!/usr/bin/env ruby

positions   = 'positions'
# dirname     = "./results#{Dir['results*'].select(&File.method(:directory?)).size}"
dirname     = './results'
FileUtils.mkdir dirname unless File.exist? dirname

require 'yaml'
images = YAML.load File.read('positions')

images.each_with_index do |image,index|
  filename = File.join dirname , "#{'%05d' % index}.png"
  next if File.exist? filename  
  puts "Drawing #{index}" # shelling out takes so long that I need it to let me know what is going on
  image[:filename] = filename
  system "./to_image.rb '#{YAML.dump image}'"
  # system "./to_image.rb '#{filename}' #{values}"
end
