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
end

