require 'spec_helper'
require 'project_euler/problems/028'

describe ProjectEuler::Problem28 do  
  specify { subject.corners_at(1).should == [1] }
  specify { subject.corners_at(2).should == [3,5,7,9] }
  specify { subject.corners_at(3).should == [13,17,21,25] }
  specify { subject.solve_for(1).should == 1 }
  specify { subject.solve_for(3).should == 1+3+5+7+9 }
  specify { subject.solve_for(5).should == 1+3+5+7+9+13+17+21+25 }
  its(:solution) { should == 669171001 }
end
