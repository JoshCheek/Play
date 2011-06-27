require 'spec_helper'
require 'project_euler/problems/025'

describe ProjectEuler::Problem25 do  
  specify { subject.solve_for(3).should == 12 }
  its(:solution) { should == 4782 }
end
