#!/usr/bin/env ruby
class HeapSort
  
  def initialize(ary,&block)
    block ||= lambda { |a,b| a.send :'<=>' , b }
    @values = ary
    @size = ary.size
    @compare = block
  end
  
  def sort!
    heapify
    @size.times do
      swap 0 , @size-=1
      bubble_down
    end
    values
  end
  
  def sort
    HeapSort.new( values.dup , &@compare ).sort!
  end

private

  attr_reader :values

  def heapify
    (@size/2).downto(0) { |i| bubble_down i }
  end
  
  def bubble_down(index=0)
    return if valid_parent?(index)
    new_index = greatest_child_index(index)
    swap index , new_index
    bubble_down new_index
  end
  
  def greatest_child_index(index)
    case num_children(index)
    when 1
      left_index(index)
    when 2
      @compare[ left_child(index) , right_child(index) ] > 0 ? left_index(index) : right_index(index)
    else
      raise "#{index} has no children for #{values.inspect}, but we're trying to find it's greatest child"
    end
  end
  
  def valid_parent?(index)
    case num_children(index)
    when 0
      true
    when 1
      geq_left?(index)
    when 2
      geq_left?(index) && geq_right?(index)
    end
  end
  
  def geq_left?(index)
    @compare[ values[index] , left_child(index) ] >= 0
  end
  
  def geq_right?(index)
    @compare[ values[index] , right_child(index) ] >= 0
  end
  
  def left_index(index)
    index*2+1
  end
  
  def right_index(index)
    left_index(index).next
  end
  
  def left_child(index)
    return nil unless valid_index? left_index(index)
    values[left_index index]
  end
  
  def right_child(index)
    return nil unless valid_index? right_index(index)
    values[right_index index]
  end
  
  def num_children(index)
    !left_child(index) ? 0   :   !right_child(index) ? 1   :   2
  end
  
  def swap(i1,i2)
    values[i1] , values[i2] = values[i2] , values[i1]
  end
  
  def valid_index?(index)
    index < @size
  end
end



class Array
  def heapsort(&block)
    HeapSort.new( self , &block ).sort
  end  
  def heapsort!(&block)
    HeapSort.new( self , &block ).sort!
  end
end



$dirname = "./results#{Dir['results*'].select(&File.method(:directory?)).size}"
FileUtils.mkdir $dirname
VALUES      = 100
STROKE      = 2
HEIGHT      = VALUES
WIDTH       = VALUES * STROKE
$imagecount = 0
require 'rubygems'
require 'rmagick'
def to_image(ary)
  canvas = Magick::ImageList.new
  canvas.new_image WIDTH , HEIGHT do
    self.background_color = 'black'
  end
  lines = Magick::Draw.new
  lines.stroke = 'white'
  lines.stroke_width = STROKE
  ary.each_with_index do |value,index|
    lines.line index*STROKE , HEIGHT , index*STROKE , HEIGHT-value
  end
  lines.draw canvas
  canvas.write File.join($dirname , "#{$imagecount}.png" )
  $imagecount += 1
end


ary = (0...100).to_a.shuffle
puts "Before sort: #{ary.inspect}"
puts
puts "After sort: #{ary.heapsort.inspect}"
to_image ary