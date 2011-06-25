require 'spec_helper'
require 'project_euler/problems/003'

describe ProjectEuler::Problem3 do
  its(:solution) { should == 6857 }
end
