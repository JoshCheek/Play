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
  
  def sort!( left=0 , right=size )
    return unless left < right
    pivot = left
    left.next.upto right-1 do |crnt|
      if @compare[ values[pivot] , values[crnt] ] > 0
        next_up = values[crnt]
        crnt.downto(pivot+1) { |i| values[i] = values[i-1] }  # creative liberties ;P 
        values[pivot] = next_up                               # older versions had a more strict interpretation, but I felt it was confusing
        pivot += 1
      end
      @pivot           = [pivot]
      @before_pivot    = (0...values.size).to_a.slice left    , pivot-left
      @after_pivot     = (0...values.size).to_a.slice pivot+1 , crnt-pivot
      @to_evaluate     = (0...values.size).to_a.slice crnt+1  , right-crnt-1
      @outside_domain  = (0...values.size).to_a - @before_pivot - @after_pivot - @to_evaluate - @pivot
      draw
    end
    sort! left    , pivot
    sort! pivot+1 , right
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


  def draw( all_green = false )
    green     = :'#00EE00'
    darkred   = :'#660000'
    darkblue  = :'#002C85'
    blue      = :'#00AEEF'
    magenta   = :'#F8A1FE'
    peach     = :'#FF9966'
    lavender  = :'#CCCCFF'
    white     = :'#FFFFFF'
    if all_green
      super values.dup , :colors => { green => values.dup }
    else
      super values.dup , :colors => { magenta => @after_pivot , blue => @before_pivot , white => @to_evaluate , green => @outside_domain+@pivot }
    end
  end

  def size
    values.size
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
