module ProjectEuler
  module TriangleNumbers
    
    extend Enumerable
    
    def self.each
      if block_given?
        (1..Float::INFINITY).inject(0) do |sum, crnt|
          sum += crnt
          yield sum
          sum
        end
      else
        Enumerator.new { |yielder| each(&yielder.method(:<<)) }
      end
    end
    
  end
end
