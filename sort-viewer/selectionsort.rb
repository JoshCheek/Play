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


class SelectionSort
  
  def initialize(ary,&block)
    block ||= lambda { |a,b| a <=> b }
    @values     =  ary
    @compare    =  block
  end
  
  def sort!
    draw :white
    @last = 0                   # last index of the sorted left
    values.size.times do
      select
      insert
      @last = @last.next
    end
    draw :'#00EE00' # green
    values
  end
  
  def sort
    self.class.new( values.dup , &@compare ).sort!
  end
  
private

  def select
    @to_insert = @last
    (@last...size).each do |crnt|
      @crnt = crnt
      @to_insert = crnt if @compare[ values[@to_insert] , values[@crnt] ] > 0 # find the smallest item
      draw
    end
  end
  
  def insert
    values[@to_insert] , values[@last] = values[@last] , values[@to_insert]
    draw
  end


  def draw( all_coloured = nil )
    green     = :'#00EE00'
    darkred   = :'#660000'
    darkblue  = :'#002C85'
    blue      = :'#00AEEF'
    magenta   = :'#F8A1FE' # :'#662D91'
    peach     = :'#FF9966'
    lavender  = :'#CCCCFF'
    white     = :'#FFFFFF'
    if all_coloured
      super values.dup , :colors => { all_coloured => values.dup }
    else
      super values.dup , :colors => { 
        green    =>  Array(0...@last)   ,
        blue     =>  [@to_insert,@last] ,
        magenta  =>  [@crnt]            ,
        white    =>  Array(@last...size) - [ @to_insert , @crnt , @last ]
      }
    end
  end
  
  def size
    values.size
  end

  attr_reader :values

end



class Array
  def selectionsort(&block)
    SelectionSort.new( self , &block ).sort
  end  
  def selectionsort!(&block)
    SelectionSort.new( self , &block ).sort!
  end
end



unless ARGV.size == 1 && ARGV.first =~ /\A[1-9][0-9]*\Z/
  puts "Usage: $ #{$0} [positive quantity of numbers to sort]"
  exit 1
end

ary = (0...ARGV.first.to_i).to_a.shuffle
puts "Before sort: #{ary.inspect}"
puts "After sort: #{ary.selectionsort!.inspect}"
