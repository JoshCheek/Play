require 'spec_helper'
require 'project_euler/problems/004'

describe ProjectEuler::Problem4 do
  its(:solution) { should == 906609 }
end
