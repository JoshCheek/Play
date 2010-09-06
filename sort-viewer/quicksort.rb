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


class QuickSort
  
  def initialize(ary,&block)
    block ||= lambda { |a,b| a.send :'<=>' , b }
    @values   =  ary
    @compare  =  block
  end
  
  def sort!( left=0 , right=values.size )
    return unless left < right
    wall = left
    left.next.upto right-1 do |crnt|
      if @compare[ values[wall] , values[crnt] ] > 0
        swap crnt , wall+1
        swap wall , wall+1
        wall += 1
        @blues  = (0...values.size).to_a.slice left   , wall-left
        @reds   = (0...values.size).to_a.slice wall+1 , right-wall-1
        @whites = (0...values.size).to_a - @blues - @reds
        draw
      end
    end
    sort! left   , wall
    sort! wall+1 , right
    values
  end
  
  def sort
    qs = self.class.new( values.dup , &@compare )
    sorted = qs.sort!
    qs.send :draw , true
    sorted
  end
  
private

  def swap( i1 , i2 )
    values[i1] , values[i2] = values[i2] , values[i1]
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
  def bubblesort(&block)
    QuickSort.new( self , &block ).sort
  end  
  def bubblesort!(&block)
    QuickSort.new( self , &block ).sort!
  end
end



unless ARGV.size == 1 && ARGV.first =~ /\A[1-9][0-9]*\Z/
  puts "Usage: $ #{$0} [positive quantity of numbers to sort]"
  exit 1
end

ary = (0...ARGV.first.to_i).to_a.shuffle
puts "Before sort: #{ary.inspect}"
puts "After sort: #{ary.bubblesort.inspect}"
