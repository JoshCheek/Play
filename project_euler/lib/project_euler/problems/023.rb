require 'project_euler'

module ProjectEuler
  class Problem23
    
    def abundants_upto(n)
      abundants = proper_divisors_upto(n)
      abundants = abundants.each.with_index.select { |divisors, index| abundant? index.next, divisors }
      abundants.map! { |divisors, index| index.next }
    end
    
    def proper_divisors_upto(n)
      (1..n).map(&:proper_divisors)
    end
    
    def abundant?(n, factors)
      n < factors.sum
    end
    
    def sum_of_two_abundants(n)
      sums_of_2 = Array.new n+1
      abundants = abundants_upto n
      abundants.each do |abundant1|
        abundants.each do |abundant2|
          sum_of_2 = abundant1 + abundant2
          break if sum_of_2 > n
          sums_of_2[sum_of_2] = true
        end
      end
      sums_of_2
    end
    
    def solve_for(n)      
      sum_of_two_abundants(n).each.with_index.inject 0 do |sum, (is_sum_of_2, num)|
        if is_sum_of_2
          sum
        else
          sum + num
        end
      end
    end
    
    def solution
      solve_for(28000)
    end
    
  end
end
