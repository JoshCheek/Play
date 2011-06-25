require 'spec_helper'
require 'project_euler/problems/002'

describe ProjectEuler::Problem2 do
  its(:solution) { should == 4613732 }
end
