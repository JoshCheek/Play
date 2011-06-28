require 'project_euler/core_extensions/integer'

module ProjectEuler
  module Primes
  
    extend Enumerable
  
    @primes = []
  
    def self.each
      if block_given?
        @primes.each { |prime| yield prime }
        loop do
          get_next
          yield @primes.last
        end
      else
        Enumerator.new { |yielder| each(&yielder.method(:<<)) }
      end
    end
  
    def self.prime?(num)
      return false if num < 2
      return true if 2 == num || 3 == num || 5 == num
      each_upto(Math::sqrt(num).to_i.next) { |potential_factor| return false if potential_factor.divide? num }
      true
    end
  
    def self.each_upto(max)
      if block_given?
        each do |crnt|
          break if crnt > max
          yield crnt
        end
      else
        Enumerator.new { |yielder| each_upto(max, &yielder.method(:<<)) }
      end
    end
  
    def self.nth(n)
      get_next until @primes.size >= n
      @primes[n-1]
    end
    
  private
    def self.get_next
      return @primes[0] = 2 if @primes.empty?
      last = @primes[-1]
      loop do
        last += 1
        return @primes << last if prime? last
      end
    end
  end
end
