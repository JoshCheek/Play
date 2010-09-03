#!/usr/bin/env ruby

def draw( values , colours=Hash.new )
  $results ||= begin
    at_exit do
      File.open "positions" , "w" do |file|
        require 'yaml'
        file.puts YAML::dump($results)
      end
    end
    Array.new
  end
  $results << colours.merge(:values => values)
end


class HeapSort
  
  def initialize(ary,&block)
    block ||= lambda { |a,b| a.send :'<=>' , b }
    @values  = ary
    @size    = ary.size
    @compare = block
  end
  
  def sort!
    heapify
    @size.times do
      reset_reds_blues
      @size -= 1
      @blues = get_bubble_path( 0 , values[@size] )
      @reds  = [0]
      swap 0 , @size
      bubble_down
    end
    values
  end
  
  def sort
    HeapSort.new( values.dup , &@compare ).sort!
  end

private

  attr_reader :values , :reds , :blues
  
  def bubble_down(index=0)
    return if valid_parent?(index)
    @blues = [index] + get_bubble_path(index)
    get_bubble_path(index).each do |new_index|
      @reds = [new_index]
      @blues -= @reds
      swap index , new_index
      @blues += @reds
      index = new_index
    end
    reset_reds_blues
  end
  
  
  def draw
    super values.dup , :whites => values-reds-blues , :reds => reds.dup , :blues => blues.dup
  end

  def reset_reds_blues
    @reds  = Array.new
    @blues = Array.new
  end

  def heapify
    (@size/2).downto(0) { |i| bubble_down i }
  end
    
  def get_bubble_path(index,crnt_value=nil)
    return Array.new if valid_parent?(index,crnt_value)
    path = Array.new
    crnt_value ||= values[index]
    while !valid_parent?(index,crnt_value)
      path << greatest_child_index(index)   
      index = path.last
    end
    path
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
  
  def valid_parent?(index,value=nil)
    case num_children(index)
    when 0
      true
    when 1
      geq_left?(index,value)
    when 2
      geq_left?(index,value) && geq_right?(index,value)
    end
  end
  
  def geq_left?(index,value=nil)
    value ||= values[index]
    @compare[ value , left_child(index) ] >= 0
  end
  
  def geq_right?(index,value=nil)
    value ||= values[index]
    @compare[ value , right_child(index) ] >= 0
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
    draw
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





ary = (0...200).to_a.shuffle
puts "Before sort: #{ary.inspect}"
puts "After sort: #{ary.heapsort!.inspect}"
