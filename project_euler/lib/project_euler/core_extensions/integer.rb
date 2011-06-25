require 'project_euler/primes'


class Integer
  
  def divide?(num)
    num % self == 0
  end
  
  def prime_factorization
    return [self] if prime?
    working_num = self
    factors = []
    i = 1
    begin
      i += 1
      while i.divide?(working_num)
        working_num /= i
        factors << i
      end
    end while i <= working_num
    factors
  end
  
  def prime_factors
    factors = prime_factorization
    factors.uniq!
    factors.sort!
  end
  
  def digits
    to_s.each_char.map(&:to_i)
  end
  
  def prime?
    ProjectEuler::Primes.prime? self
  end
  
  def factors
    each_combination = lambda do |ary|
      return ary if ary.empty?
      crnt = ary.shift
      without_crnt = each_combination[ary]
      with_crnt = without_crnt.dup
      without_crnt.each { |factor| with_crnt << (factor*crnt) }
      with_crnt << crnt
      with_crnt.uniq!
      with_crnt
    end
    results = each_combination[prime_factorization].sort
    results.unshift(1)
    results
  end
  
  def factorial
    product = 1
    1.upto self do |crnt|
      product *= crnt
    end
    product
  end
  
  def choose(k)
    self.factorial / (k.factorial * (self-k).factorial)
  end
  
end

