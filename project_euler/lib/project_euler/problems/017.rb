require 'project_euler/core_extensions/integer'
require 'project_euler/core_extensions/enumerable'

module ProjectEuler
  class Problem17
    
    ONES = {
      0 => ''.size,
      1 => 'one'.size,
      2 => 'two'.size,
      3 => 'three'.size,
      4 => 'four'.size,
      5 => 'five'.size,
      6 => 'six'.size,
      7 => 'seven'.size,
      8 => 'eight'.size,
      9 => 'nine'.size,
    }
    
    TEENS = {
      11 => 'eleven'.size,
      12 => 'twelve'.size,
      13 => 'thirteen'.size,
      14 => 'fourteen'.size,
      15 => 'fifteen'.size,
      16 => 'sixteen'.size,
      17 => 'seventeen'.size,
      18 => 'eighteen'.size,
      19 => 'nineteen'.size,
    }
    
    TENS = {
      1 => 'ten'.size,
      2 => 'twenty'.size,
      3 => 'thirty'.size,
      4 => 'forty'.size,
      5 => 'fifty'.size,
      6 => 'sixty'.size,
      7 => 'seventy'.size,
      8 => 'eighty'.size,
      9 => 'ninety'.size,
    }
    
    HUNDREDS = ONES.each.with_object Hash.new do |(num, num_chars), hundreds|
      hundreds[num] = num_chars + 'hundred'.size
    end
    
    def self.num_letters(num)
      case num.num_digits
      when 1
        ONES[num]
      when 2
        if 10 < num && num < 20
          TEENS[num]
        else
          TENS[num/10] + num_letters(num%10)
        end
      when 3
        hundreds =  HUNDREDS[num/100]
        rest = num_letters(num%100)
        return hundreds if rest.zero?
        hundreds + 'and'.size + rest
      when 4
        return 'OneThousand'.size if num == 1000
        raise "unexpected number #{num}"
      else
        raise "unexpected number #{num}"
      end
    end
    
    def self.solve_for(n)
      (1..n).map(&method(:num_letters)).sum
    end
    
    def solution
      self.class.solve_for 1000
    end
        
  end
end
