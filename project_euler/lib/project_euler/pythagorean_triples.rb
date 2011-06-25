module ProjectEuler
  class PythagoreanTriples
  
    extend Enumerable
  
    def self.each
      if block_given?
        (2..Float::INFINITY).each do |n|
          (n-1).downto 0 do |m|
            next if m.zero?
            n2 = n*n
            m2 = m*m
            a  = n2-m2
            b  = 2*m*n
            c  = n2+m2
            a, b = b, a if b < a
            yield a, b, c
          end
        end
      else
        Enumerator.new { |yielder| each(&yielder.method(:<<)) }
      end
    end
  
  end
end