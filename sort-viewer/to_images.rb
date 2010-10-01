#!/usr/bin/env jruby

require 'fileutils'

include Java
import javax.imageio.ImageIO
import java.awt.image.BufferedImage
import java.awt.image.WritableRaster


positions   = 'positions'
dirname     = './results'
FileUtils.mkdir dirname unless File.exist? dirname

def to_rgb(colour)
  case colour
  when :red , 'red'
    :'#FF0000'
  when :blue , 'blue'
    :'#0000FF'
  when :green , 'green'
    :'#00FF00'
  when :white , 'white'
    :'#FFFFFF'
  when :black , 'black'
    :'#000000'
  else
    colour
  end.to_s.delete('#').scan(/../).map { |component| component.to_i(16) }.to_java(:int)
end


images = Marshal.load File.read('positions')

images.each_with_index do |image,index|
  filename = File.join dirname , "#{'%05d' % index}.gif"
  next if File.exist? filename  
  puts "Drawing #{index}"
  
  values       = image[:values]
  pixel_height = 2
  pixel_width  = 3
  height       = values.size * pixel_height
  width        = values.size * pixel_width

  canvas = BufferedImage.new width , height , BufferedImage::TYPE_INT_RGB
  pixels = canvas.get_raster

  add_lines = lambda do |colour,to_add,location|
    colours = to_rgb(colour)
    to_add.each do |index|
      start_y , end_y = [ location == :background ? 0 : height   ,   height - values[index]*pixel_height ].sort
      for x in pixel_width*index ... start_x+pixel_width
        for y in start_y ... end_y
          pixels.set_pixel x , y , colours
        end
      end
    end
  end

  image[:colors] ||= Array.new
  image[:colors].each do |color,indexes|
    add_lines[ color.to_s , indexes , :foreground ]
  end

  image[:background_colors] ||= Array.new
  image[:background_colors].each do |color,indexes|
    add_lines[ color.to_s , indexes , :background ]  
  end
  
  ImageIO.write canvas , "gif" , java.io.File.new(filename)
end
