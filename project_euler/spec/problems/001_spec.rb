require 'spec_helper'
require 'project_euler/problems/001'

describe ProjectEuler::Problem1 do
  its(:solution) { should == 233168 }
end

