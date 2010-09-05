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


class BubbleSort
  
  def initialize(ary,&block)
    block ||= lambda { |a,b| a.send :'<=>' , b }
    @values   =  ary
    @compare  =  block
  end
  
  def sort!
    draw true
    @last = values.size
    values.size.times do
      @reds   = [0]          # red index is the "head" or the one we are currently moving
      @blues  = Array.new    # blue indexes are the previous heads for this iteration
      draw
      bubble_up
      @last -= 1
    end
    values
  end
  
  def sort
    self.class.new( values.dup , &@compare ).sort!
  end
  
private

  def bubble_up(index=0)
    until index.next >= @last
      if @compare[ values[index] , values[index.next] ] > 0
        values[index] , values[index.next] = values[index.next] , values[index]
      else
        @blues << index
      end
      index = index.next
      @reds = [index]
      draw
    end
  end

  def draw( all_white = false )
    if all_white
      super values.dup , :whites => values.dup
    else
      super values.dup , :reds => @reds.dup , :blues => @blues.dup , :whites => (0...values.size).to_a-@reds-@blues
    end
  end

  attr_reader :values

end



class Array
  def bubblesort(&block)
    BubbleSort.new( self , &block ).sort
  end  
  def bubblesort!(&block)
    BubbleSort.new( self , &block ).sort!
  end
end



ary = (0...200).to_a.shuffle
puts "Before sort: #{ary.inspect}"
puts "After sort: #{ary.bubblesort!.inspect}"
