module ProjectEuler
  module Fibs
  
    extend Enumerable
  
    def self.each(&block)
      if block_given?
        a, b = 0, 1
        loop do
          yield a
          a, b = a+b, a
        end
      else
        Enumerator.new { |yielder| each(&yielder.method(:<<)) }
      end
    end
    
  end
end
