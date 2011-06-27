require 'project_euler'

module ProjectEuler
  class Problem24
    
    def solution
      (0..9).to_a.permutation.with_index do |digits, index|
        return digits.join.to_i if index.next == 1_000_000
      end
    end
    
  end
end
