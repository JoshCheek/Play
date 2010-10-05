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
    @reds = @blues = []
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
    green     = :'#00EE00'
    darkred   = :'#660000'
    darkblue  = :'#002C85'
    blue      = :'#00AEEF'
    magenta   = :'#F8A1FE' # :'#662D91'
    
    if all_white
      super values.dup , :colors => { :white => values.dup }
    else
      super values.dup , :colors => { magenta => @reds.dup , blue => @blues.dup , :white => (0...@last).to_a-@reds-@blues , green => Array(@last...values.size)}
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


unless ARGV.size == 1 && ARGV.first =~ /\A[1-9][0-9]*\Z/
  puts "Usage: $ #{$0} [positive quantity of numbers to sort]"
  exit 1
end

ary = (0...ARGV.first.to_i).to_a.shuffle
puts "Before sort: #{ary.inspect}"
puts "After sort: #{ary.bubblesort!.inspect}"
