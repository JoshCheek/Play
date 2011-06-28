require 'spec_helper'
require 'project_euler/problems/026'

describe ProjectEuler::Problem26 do  
  specify { subject.recurring_period(1).should == 0 }
  specify { subject.recurring_period(2).should == 0 }
  specify { subject.recurring_period(3).should == 1 }
  specify { subject.recurring_period(4).should == 0 }
  specify { subject.recurring_period(5).should == 0 }
  specify { subject.recurring_period(6).should == 1 }
  specify { subject.recurring_period(7).should == 6 }
  specify { subject.recurring_period(8).should == 0 }
  specify { subject.recurring_period(9).should == 1 }
  specify { subject.recurring_period(10).should == 0 }
  
  specify { subject.solve_for(10).should == 7 }
  its(:solution) { should == 983 }
end
