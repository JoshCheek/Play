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
  to_add = colours.merge(:values => values)
  $results << to_add unless $results.last == to_add
end


class MergeSort
  
  def initialize(ary,first=nil,last=nil,&block)
    block ||= lambda { |a,b| a.send :'<=>' , b }
    @values    =  ary
    @compare   =  block
    @sections  =  Array.new(ary.size.next/2) do |i|
      first  = i * 2
      second = first + 1
      Section.new values[first...second] , values[second..second] , block
    end
  end
  
  def sort!
    until @sections.size == 1 && @sections.first.sorted?
      until @sections.all?(&:sorted?)
        @sections.each { |section| section.sort_iteration }
        draw
      end
      @sections = @sections.each_slice(2).map do |sections|
        s1 = sections.shift # have to do it this way b/c jruby doesn't support default values for block args
        s2 = sections.shift # s2 might be nil, indicating an odd number of sections, and thus no pair for s1
        if s2
          Section.new s1.merged , s2.merged , @compare
        else
          s1
        end
      end
      draw
    end
    @values = @sections.first.merged
  end
  
  def sort
    self.class.new( values.dup , &@compare ).sort!
  end

private

  class Section
    attr_accessor :merged , :left , :right , :compare , :from_left , :from_right
    def inspect
      "<SECTION: merged=#{merged.inspect} left=#{left.inspect} right=#{right.inspect} from_left=#{from_left.inspect} from_right=#{from_right.inspect}>"
    end
    def initialize( left , right , compare )
      @left , @right , @compare = left , right , compare
      @merged , @from_left , @from_right = [] , [] , []
    end
    def indexes_from_left(offset)
      @from_left.map { |i| i + offset } + (0...left.size).map { |i| offset + merged.size + i }
    end
    def indexes_from_right(offset)
      @from_right.map { |i| i + offset } + (0...right.size).map { |i| offset + merged.size + left.size + i }
    end
    def sort_iteration
      return if sorted?
      merged << extract_next
    end
    def sorted?
      left.empty? && right.empty?
    end
    def extract_next
      if sorted?
        nil
      elsif left.empty?
        extract_right
      elsif right.empty?
        extract_left
      else
        if compare[ left.first , right.first ] < 0 then extract_left else extract_right end
      end
    end
    def extract_right
      to_return = right.shift
      @from_right << merged.size
      to_return
    end
    def extract_left
      to_return = left.shift
      @from_left << merged.size
      to_return
    end
    def size
      left.size + right.size + merged.size
    end
  end

  def draw
    green         = :'#00EE00'
    darkred       = :'#660000'
    darkblue      = :'#002C85'
    blue          = :'#00AEEF'
    magenta       = :'#F8A1FE'
    @values       = @sections.map { |s| [ s.merged , s.left , s.right ] }.flatten    
    offset        = 0
    left_indexes  = @sections.map { |section| indexes = section.indexes_from_left(offset)  ; offset += section.size ; indexes }.flatten
    offset        = 0
    right_indexes = @sections.map { |section| indexes = section.indexes_from_right(offset) ; offset += section.size ; indexes }.flatten 
    super values.dup , :colors => { magenta => left_indexes , blue => right_indexes }
  end

  attr_reader :values , :last , :first
  
end



class Array
  def mergesort(&block)
    MergeSort.new( self , &block ).sort
  end  
  def mergesort!(&block)
    MergeSort.new( self , &block ).sort!
  end
end



unless ARGV.size == 1 && ARGV.first =~ /\A[1-9][0-9]*\Z/
  puts "Usage: $ #{$0} [positive quantity of numbers to sort]"
  exit 1
end

ary = (0...ARGV.first.to_i).to_a.shuffle
puts "Before sort: #{ary.inspect}"
puts "After sort: #{ary.mergesort!.inspect}"
