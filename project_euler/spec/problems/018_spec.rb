require 'spec_helper'
require 'project_euler/problems/018'

describe ProjectEuler::Problem18 do

  context "little triangle" do
    subject do
      ProjectEuler::Problem18.new <<-TRIANGLE
         3
        7 4
       2 4 6
      8 5 9 3
      TRIANGLE
    end
    its :triangle do 
      should == [
           [3],
          [7,4],
         [2,4,6],
        [8,5,9,3],
      ]
    end
    its(:solution) { should == 23 }
  end
  
  its(:solution) { should == 1074 }
  
end
