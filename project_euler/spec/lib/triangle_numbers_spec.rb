require 'spec_helper'
require 'project_euler/triangle_numbers'

describe ProjectEuler::TriangleNumbers do
  
  let(:expected) { [1, 3, 6, 10, 15, 21, 28, 36, 45, 55] }
  
  specify '.each should yield ascending triangle numbers' do
    nums = []
    ProjectEuler::TriangleNumbers.each do |num|
      nums << num
      break if nums.size == 10
    end
    nums.should == expected
  end
  
  specify '.each should return an enumerator if no block is given' do
    ProjectEuler::TriangleNumbers.each.take(10).should == expected
  end
  
  specify 'should be enumerable' do
    ProjectEuler::TriangleNumbers.take(10).should == expected
  end
  
end
