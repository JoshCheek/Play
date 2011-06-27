require 'spec_helper'
require 'project_euler/problems/029'

describe ProjectEuler::Problem29 do  
  specify { subject.solve_for(5).should == 15 }
  its(:solution) { should == 9183 }
end
