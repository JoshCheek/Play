require 'spec_helper'
require 'project_euler/problems/009'

describe ProjectEuler::Problem9 do
  its(:solution) { should == 31875000 }
end
