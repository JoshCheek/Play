#!/usr/bin/env ruby

require 'yaml'

image = YAML.load ARGV.first

filename = image[:filename]

exit if File.exist? filename

values       = image[:values]
pixel_height = 2
pixel_width  = 3
height       = values.size * pixel_height
width        = values.size * pixel_width


require 'rubygems'
require 'rmagick'

# canvas
canvas = Magick::ImageList.new
canvas.new_image( width , height ) { self.background_color = 'black' }

add_lines = lambda do |colour,to_add|
  to_add ||= Array.new
  lines    = Magick::Draw.new
  lines.stroke = colour
  lines.stroke_width = pixel_width
  to_add.each do |index| 
    value = values[index]
    lines.line  index*pixel_width         , 
                height                    , 
                index*pixel_width         , 
                height-value*pixel_height
  end
  lines.draw canvas unless to_add.empty?
end

image[:colors].each do |color,indexes|
  add_lines[ color.to_s , indexes ]
end

canvas.set_channel_depth(Magick::AllChannels,8)
canvas.colorspace = Magick::RGBColorspace
canvas.write filename