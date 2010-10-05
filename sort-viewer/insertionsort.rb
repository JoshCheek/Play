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
    @last = 0                   # last index of the sorted left
    @crnt_color ||= :'#F8A1FE'  # magenta
    @next_color ||= :'#00EE00'  # green
    values.size.times do
      @crnt_color , @next_color = @next_color , @crnt_color
      @next = @last+1 unless @last+1 == values.size
      insert
      @reds = Array.new
      @blues = Array(0..@last)
      draw
      @last = @next
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
    until to_move <= 0 || @compare[ values[to_move] , values[to_move-1] ] >= 0
      to_move -= 1
      @reds = [to_move]
      @blues = Array(0..@last) - @reds
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
      super values.dup , :colors => { @crnt_color => @reds.dup , @next_color => [@next] , blue => @blues.dup , :white => (0...values.size).to_a-@reds-@blues-[@next] }
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
