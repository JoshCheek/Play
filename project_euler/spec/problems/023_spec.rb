require 'spec_helper'
require 'project_euler/problems/023'

describe ProjectEuler::Problem23 do 
  
  it 'should be able to find proper divisors for numbers' do
    subject.proper_divisors_upto(5).should == [
      [1],    # 1
      [1],    # 2
      [1],    # 3
      [1,2],  # 4
      [1],    # 5
    ]
  end
  
  it 'should be able to find abundant numbers' do
    subject.abundants_upto(100).should == [12, 18, 20, 24, 30, 36, 40, 42, 48, 54, 56, 60, 66, 70, 72, 78, 80, 84, 88, 90, 96, 100]
  end 
  
  it "should know what numbers can and can't be written as the sum of two abundants" do
    subject.sum_of_two_abundants(50).should == [
       nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil, #  0.. 9
       nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil, # 10..19
       nil,  nil,  nil,  nil, true,  nil,  nil,  nil,  nil,  nil, # 20..29
      true,  nil, true,  nil,  nil,  nil, true,  nil, true,  nil, # 30..39
      true,  nil, true,  nil, true,  nil,  nil,  nil, true,  nil, # 40..49
      true,                                                       # 50
    ]
    subject.solve_for(50).should == ((1..50).to_a - [24, 30, 32, 36, 38, 40, 42, 44, 48, 50]).sum
  end
  
  its(:solution) { should == 4179871 }
  
end
