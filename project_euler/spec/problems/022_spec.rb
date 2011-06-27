require 'spec_helper'
require 'project_euler/problems/022'

describe ProjectEuler::Problem22 do
  
  specify { subject.char_value('A').should == 1 }
  specify { subject.char_value('Z').should == 26 }
  
  specify { subject.name_value('COLIN').should == 53 }
  
  context 'for COLIN and ABCDE' do
    subject do
      ProjectEuler::Problem22.new("COLIN
                                   ABCDE")
    end
    its(:names)     { should == %w[ABCDE COLIN] }
    its(:solution)  { should == 1*(1+2+3+4+5) + 2*53 }
  end
  
  its(:solution) { should == 871198282 }
end
