require 'spec_helper'
require 'project_euler/problems/007'

describe ProjectEuler::Problem7 do
  its(:solution) { should == 104743 }
end
