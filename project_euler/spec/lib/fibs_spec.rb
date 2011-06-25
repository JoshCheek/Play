require 'spec_helper'
require 'project_euler/fibs'


describe ProjectEuler::Fibs do
  
  let(:expected) { [0, 1, 1, 2, 3, 5, 8, 13, 21, 34] }
  
  specify 'each should yield the fibonacci sequence' do
    fibs = []
    ProjectEuler::Fibs.each do |fib|
      fibs << fib
      break if fibs.size == 10
    end
    fibs.should == expected
  end
  
  specify 'each w/o a block should return an enumerator that yields the fib sequence' do
    fibs = []
    ProjectEuler::Fibs.each.each do |fib|
      fibs << fib
      break if fibs.size == 10
    end
    fibs.should == expected
  end
  
  specify 'it should match the enumerator methods' do
    ProjectEuler::Fibs.take(10).should == expected
  end
  
end
