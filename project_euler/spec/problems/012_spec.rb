require 'spec_helper'
require 'project_euler/problems/012'

describe ProjectEuler::Problem12 do
  its(:solution) { should == 76576500 }
end
