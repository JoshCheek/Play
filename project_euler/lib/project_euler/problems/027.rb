require 'project_euler'

module ProjectEuler
  class Problem27
    
    def length(a, b)    
      (0...Float::INFINITY).each do |n|
        result = n*n + a*n + b
        return n unless result.prime?
      end
    end
    
    def solution
      result = Struct.new :a, :b, :length
      best = nil
      Primes.each_upto(1000) do |b|
        (-1000..1000).each do |a|
          crnt_result = result.new a, b, length(a, b)
          best = crnt_result if !best || best.length < crnt_result.length
        end
      end
      best.a * best.b
    end
    
  end
end
