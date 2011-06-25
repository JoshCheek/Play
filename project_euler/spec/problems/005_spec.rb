require 'spec_helper'
require 'project_euler/problems/005'

describe ProjectEuler::Problem5 do
  its(:solution) { should == 232792560 }
end
