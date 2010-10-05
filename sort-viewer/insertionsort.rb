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
    green     = :'#00EE00'
    darkred   = :'#660000'
    darkblue  = :'#002C85'
    blue      = :'#00AEEF'
    magenta   = :'#F8A1FE' # :'#662D91'
    peach     = :'#FF9966'
    lavender  = :'#CCCCFF'
    
    if all_white
      super values.dup , :colors => { :white => values.dup }
    else
      super values.dup , :colors => { magenta => @reds.dup , blue => @blues.dup , :white => (0...values.size).to_a-@reds-@blues }
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



unless ARGV.size == 1 && ARGV.first =~ /\A[1-9][0-9]*\Z/
  puts "Usage: $ #{$0} [positive quantity of numbers to sort]"
  exit 1
end

ary = (0...ARGV.first.to_i).to_a.shuffle
puts "Before sort: #{ary.inspect}"
puts "After sort: #{ary.insertionsort!.inspect}"
