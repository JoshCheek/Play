require 'spec_helper'
require 'project_euler/problems/011'

describe ProjectEuler::Problem11 do
  its(:solution) { should == 70600674 }
end
