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


class InsertionSort
  
  def initialize(ary,&block)
    block ||= lambda { |a,b| a.send :'<=>' , b }
    @values   =  ary
    @compare  =  block
  end
  
  def sort!
    draw true
    @last = 0                # last index of the sorted left
    values.size.times do
      insert
      @last += 1
    end
    draw true
    values
  end
  
  def sort
    self.class.new( values.dup , &@compare ).sort!
  end
  
private

  def insert
    to_move = @last
    @blues = Array.new
    until to_move <= 0 || @compare[ values[to_move] , values[to_move-1] ] >= 0
      @blues << to_move
      to_move -= 1
      @reds = [to_move]
      values[to_move] , values[to_move+1] = values[to_move+1] , values[to_move]
      draw
    end
  end


  def draw( all_white = false )
    if all_white
      super values.dup , :colors => { :white => values.dup }
    else
      super values.dup , :colors => { :red => @reds.dup , :blue => @blues.dup , :white => (0...values.size).to_a-@reds-@blues }
    end
  end

  attr_reader :values

end



class Array
  def insertionsort(&block)
    InsertionSort.new( self , &block ).sort
  end  
  def insertionsort!(&block)
    InsertionSort.new( self , &block ).sort!
  end
end



ary = (0...25).to_a.shuffle
puts "Before sort: #{ary.inspect}"
puts "After sort: #{ary.insertionsort!.inspect}"
