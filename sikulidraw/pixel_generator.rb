#!/usr/bin/env ruby

unless ARGV.size == 1 && File.exist?(ARGV.first)
  puts "usage: $ #{$0} path_to_picture"
  exit 1
end

WIDTH_MIN = 280
WIDTH_MAX = 890

HEIGHT_MIN = 125
HEIGHT_MAX = 575

HEIGHT = HEIGHT_MAX - HEIGHT_MIN
WIDTH  = WIDTH_MAX  - WIDTH_MIN

require 'rubygems'
require 'RMagick'

# the canvas
canvas = Magick::ImageList.new
canvas.new_image WIDTH , HEIGHT do
  self.background_color = 'black'
end

image = Magick::Image.read ARGV.first do
  self.gravity = Magick::CenterGravity
end.first

canvas.composite! image , Magick::CenterGravity , Magick::AddCompositeOp

# canvas.display
# __END__

File.open 'pixels.txt' , 'w' do |file|
  canvas.each_pixel do |pixel,x,y|
    file.puts "#{x} #{y}" if pixel.red < 5 && pixel.green < 5 && pixel.blue < 5
  end
end