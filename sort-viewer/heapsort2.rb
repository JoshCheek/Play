#!/usr/bin/env ruby

def draw( values , colours=Hash.new )
  $results ||= begin
    at_exit do
      puts "NUMBER OF IMAGES: #{$results.size}"
      File.open "positions" , "w" do |file|
        file.write Marshal.dump($results)
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
    # @size.times do
    #   reset_reds_blues
    #   @size -= 1
    #   @blues = values[1...@size]
    #   @reds  = [0]
    #   swap 0 , @size
    #   bubble_down
    # end
    # reset_reds_blues
    # draw
    values
  end
  
  def sort
    HeapSort.new( values.dup , &@compare ).sort!
  end

private

  attr_reader :values , :reds , :blues
  
  def bubble_down(index=0)
    return if valid_parent?(index)
    @blues = progeny(index)
    get_bubble_path(index).each do |new_index|
      @reds = [new_index]
      
      puts "BEFORE FIRST PROGENY, INDEX=#{index} (#{values[index]})"
      p valid_index?(index)
      p left_child(index)
      p right_child(index)
      p values
      $MAGICVAL = true if index == 2
      @blues = progeny(index)
      puts "MADE IT PAST THE FIRST PROGENY"
      puts "BLUES: #{@blues.inspect}"
      puts "VALUES: #{values.inspect}"
      puts "INDEX=#{index} , NEW_INDEX=#{new_index}"
      puts "-" * 30
      
      swap index , new_index
      index = new_index
    end
    reset_reds_blues
  end
  
  def progeny(index)
    p index if $MAGICVAL
    return [] unless valid_index?(index)
    # puts "getting progyny for #{index}"
    to_return = [index]
    to_return += progeny(left_index index)  if left_child(index)
    to_return += progeny(right_index index) if right_child(index)
    to_return
  end
  
  # red is the current element
  # blue is the path that red will traverse
  def draw
    green     = :'#7CC576'
    darkred   = :'#660000'
    darkblue  = :'#002C85'
    blue      = :'#00AEEF'
    magenta   = :'#662D91'
    greens    = values[@size...values.size]
    # super values.dup , 
    #       :colors             => { :white => values[0...@size]-reds-blues-greens , magenta => reds.dup , blue => blues.dup , :greens => greens }
    #       # :background_colors  => { darkred => reds.dup , darkblue => blues.dup }
  end

  def reset_reds_blues
    @reds  = Array.new
    @blues = Array.new
  end

  def heapify
    (@size/2).downto(0) { |i| 
      puts "heapifying at: #{i} (#{values[i]})"
      bubble_down i }
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





unless ARGV.size == 1 && ARGV.first =~ /\A[1-9][0-9]*\Z/
  puts "Usage: $ #{$0} [positive quantity of numbers to sort]"
  exit 1
end

ary = (0...ARGV.first.to_i).to_a.shuffle
ary = [3, 8, 9, 2, 6, 4, 7, 1, 5, 0]         # FIXME
puts "Before sort: #{ary.inspect}"
puts "After sort: #{ary.heapsort!.inspect}"
