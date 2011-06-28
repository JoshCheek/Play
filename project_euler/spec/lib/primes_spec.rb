require 'spec_helper'
require 'project_euler/primes'

describe ProjectEuler::Primes do
  
  let(:expected) { [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71] }
  
  specify '.each should yield primes' do
    primes = []
    ProjectEuler::Primes.each { |prime| primes << prime; break if primes.size == 20 }
    primes.should == expected
  end
  
  specify '.each should return a prime yielding enumerator if no block given' do
    primes = []
    ProjectEuler::Primes.each.each { |prime| primes << prime; break if primes.size == 20 }
    primes.should == expected
  end
  
  specify 'it should have all the usual enumerable methods' do
    ProjectEuler::Primes.take(20).should == expected
  end
  
  specify 'it should be able to tell if numbers are prime' do
    1.upto expected.last do |num|
      if ProjectEuler::Primes.prime?(num)
        expected.should include num
      else
        expected.should_not include num
      end
    end
  end
  
  specify 'it should consider non-positive numbers prime' do
    ProjectEuler::Primes.should_not be_prime(0)
    ProjectEuler::Primes.should_not be_prime(-1)
    ProjectEuler::Primes.should_not be_prime(-2)
  end
  
  specify '.each_upto should yield all the primes upto and including n' do
    primes = [2, 3, 5, 7]
    ProjectEuler::Primes.each_upto(7) { |prime| prime.should == primes.shift }
  end
  
  specify '.each_upto should return an enumerator if no block given' do
    primes = [2, 3, 5, 7]
    ProjectEuler::Primes.each_upto(7).each { |prime| prime.should == primes.shift }
  end
  
  specify '.nth(n) should return the nth prime (counting from 1)' do
    ProjectEuler::Primes.nth(1).should == 2
    ProjectEuler::Primes.nth(20).should == 71
  end
  
end



