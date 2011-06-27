require 'project_euler'

module ProjectEuler
  class Problem21
    
    def solution
      (1..10000).select(&:amicable?).sum
    end
    
  end
end
