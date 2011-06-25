require 'spec_helper'
require 'project_euler/problems/010'

describe ProjectEuler::Problem10 do
  its(:solution) { should == 142913828922 }
end
