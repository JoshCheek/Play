require 'spec_helper'
require 'project_euler/problems/030'

describe ProjectEuler::Problem30 do
  specify { subject.nth_power?(1634, 4).should be }
  specify { subject.nth_power?(8208, 4).should be }
  specify { subject.nth_power?(9474, 4).should be }
  
  specify { subject.nth_power?(1634, 3).should_not be }
  specify { subject.nth_power?(8208, 9).should_not be }
  specify { subject.nth_power?(9474, 5).should_not be }
    
  specify { subject.solve_for(4).should == 19316 }
  its(:solution) { should == 443839 }
end
