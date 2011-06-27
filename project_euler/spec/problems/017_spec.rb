require 'spec_helper'
require 'project_euler/problems/017'

describe ProjectEuler::Problem17 do
  [ [1, 3], [2, 3], [3, 5], [4, 4], [5, 4], [6, 3], [7, 5], [8, 5], [9, 4],                   # ones
    [10, 3], [11, 6], [12, 6], [13, 8], [14, 8], [15, 7], [16, 7], [17, 9], [18, 8], [19, 8], # teens
    [20, 6], [30, 6], [40, 5], [50, 5], [60, 5], [70, 7], [80, 6], [90, 6],                   # tens
    [100,10], [115,20], [342,23], [1000, 11]                                                  # others
  ].each do |num, num_letters|
    specify "#{num} should have #{num_letters} letters" do
      ProjectEuler::Problem17.num_letters(num).should == num_letters
    end
  end
  
  specify '.solve_for(5) should == 19' do
    ProjectEuler::Problem17.solve_for(5).should == 19
  end
  
  its(:solution) { should == 21124 }
end
