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


class MergeSort
  
  def initialize(ary,first=nil,last=nil,&block)
    block ||= lambda { |a,b| a.send :'<=>' , b }
    @first              =  first || 0
    @last               =  last  || ary.size
    @values             =  ary
    @compare            =  block
  end
  
  def sort!
    return values if size < 2
    middle = (first + last) / 2
    self.class.new( values , first  , middle , &@compare ).sort!
    self.class.new( values , middle , last   , &@compare ).sort!
    @initial_reds   = Array(first...middle)                             # these arrays keep track of the indexes that should be each colour
    @initial_blues  = Array(middle...last)
    @always_reds    = Array.new
    @always_blues   = Array.new
    @whites         = (0...values.size).to_a - @initial_reds - @initial_blues
    merge first , middle
    draw true
    values
  end
  
  def sort
    self.class.new( values.dup , &@compare ).sort!
  end
  
  def size
    last - first
  end

private

  def draw( all_white = false )
    if all_white
      super values.dup , :colors => { :white => values.dup }
    else
      super values.dup , :colors => { :red => @initial_reds + @always_reds , :blue => @initial_blues + @always_blues , :white => @whites }
    end
  end

  attr_reader :values , :last , :first

  # four conceptual walls for the indexes in this mergesort
  # the first and last walls, which are defined in the initialize method
  # then two more walls, one separating white from red, and one separating red from blue
  # the white indexes are first, and are the merged sorted results we are returning
  # then is the red indexes, which are the sorted left half
  # then the blue indexes, which are the sorted right half
  # each iteration, we pull the lowest from red/blue and append it to the end of white
  # then shift any values down as necessary, and repeat until there are no more red/blue
  def merge( red , blue )
    return if red==blue || blue==last                     # base case: red or blue are empty
    if @compare[values[red],values[blue]] <= 0            # first red is less than first blue
      @always_reds << @initial_reds.shift
    else                                                  # first blue is less than first red
      tmp = values[blue]
      blue.downto(red) { |i| values[i] = values[i-1] }
      values[red] = tmp
      blue+=1
      @initial_reds << @initial_blues.shift
      @always_blues << @initial_reds.shift
      draw                                                # lines are moving, so draw the current state as an image
    end
    red+=1                                                # red sits in front of blue, so whether we pull from red or blue, red shifts over 1
    merge( red , blue )
  end
  
end



class Array
  def mergesort(&block)
    MergeSort.new( self , &block ).sort
  end  
  def mergesort!(&block)
    MergeSort.new( self , &block ).sort!
  end
end



ary = (0...25).to_a.shuffle
puts "Before sort: #{ary.inspect}"
puts "After sort: #{ary.mergesort!.inspect}"
