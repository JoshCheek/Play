require 'spec_helper'
require 'project_euler/problems/006'

describe ProjectEuler::Problem6 do
  its(:solution) { should == 25164150 }
end
