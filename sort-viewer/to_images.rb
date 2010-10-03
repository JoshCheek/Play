#!/usr/bin/env jruby --server

# make the results dir
require 'fileutils'
dirname = './results'
FileUtils.mkdir dirname unless File.exist? dirname

# import the jruby classes
include Java
import javax.imageio.ImageIO
import java.awt.image.BufferedImage
import java.awt.image.WritableRaster

# set relevant variables
pixel_height = 2
pixel_width  = 3
images = Marshal.load File.read('positions')    # retrieve the processed data from the file
height = values = pixels = nil                  # declare these in enclosing scope

# converts colours, usually in the rgb hex format :'#FF0000' into the rgb format java array of [ red_int , green_int , blue_int ]
def to_rgb(colour)
  case colour
  when :red
    :'#FF0000'
  when :blue
    :'#0000FF'
  when :green
    :'#00FF00'
  when :white
    :'#FFFFFF'
  when :black
    :'#000000'
  else
    colour
  end.to_s.delete('#').scan(/../).map { |component| component.to_i(16) }.to_java(:int)
end

# pass add_lines  a colour as a java array of rgb int values, 
#                 an array of indexes to add
#                 and a location for the line of eitehr :background or :foreground
# it will add the lines to the picture that we are building
add_lines = lambda do |colour,to_add,location|
  to_add.each do |index|
    start_y , end_y = (location == :background ? 0 : height) , (height - values[index]*pixel_height)    # the array can go from zero to the height of the value, or from the height of the value to the height of the canvas
    start_y , end_y = end_y , start_y unless start_y < end_y                                            # ensure we are moving from low to high
    for x in pixel_width*index ... pixel_width*index.next
      (start_y...end_y).each { |y| pixels.set_pixel x , y , colour }
    end
  end
end


images.each_with_index do |image,index|
  
  # don't redo work that has already been done
  filename = File.join dirname , '%05d.gif'%index
  next if File.exist? filename
  
  # it takes a while, keep user updated
  puts "Drawing #{index}"
  
  # find the image's picture values (order of sortedness), and determine its width and height
  values  = image[:values]
  height  = values.size * pixel_height
  width   = values.size * pixel_width

  # http://download.oracle.com/javase/6/docs/api/java/awt/image/BufferedImage.html
  canvas = BufferedImage.new width , height , BufferedImage::TYPE_INT_RGB
  pixels = canvas.get_raster

  # extract the information about which values are which colours, and apply them to the image
  ( image[:colors]            || [] ).each { |colour,indexes| add_lines.call to_rgb(colour) , indexes , :foreground }
  ( image[:background_colors] || [] ).each { |colour,indexes| add_lines.call to_rgb(colour) , indexes , :background }
  
  # write the image to file
  ImageIO.write canvas , "gif" , java.io.File.new(filename)
end
