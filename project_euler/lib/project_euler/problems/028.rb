require 'project_euler'

module ProjectEuler
  class Problem28
    
    def corners_at(n)
      return [1] if n.one?
      offset = (n-1)*2
      d = (n+(n-1))**2
      c = d-offset
      b = c-offset
      a = b-offset
      [a, b, c, d]
    end
    
    def solve_for(n)
      upper_bound = (n+1)/2
      (1..upper_bound).map { |i| corners_at(i).sum }.sum
    end
    
    def solution
      solve_for 1001
    end
    
  end
end
