require 'spec_helper'
require 'project_euler/problems/027'

describe ProjectEuler::Problem27 do
  specify { subject.length(1, 41).should == 40 }
  specify { subject.length(-79, 1601).should == 80 }
  
  its(:solution) { should == -59231 }
end
