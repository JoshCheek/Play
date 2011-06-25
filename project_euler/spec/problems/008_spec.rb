require 'spec_helper'
require 'project_euler/problems/008'

describe ProjectEuler::Problem8 do
  its(:solution) { should == 40824 }
end
