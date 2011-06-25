require 'spec_helper'
require 'project_euler/problems/015'

describe ProjectEuler::Problem15 do
  its(:solution) { should == 137846528820 }
end
