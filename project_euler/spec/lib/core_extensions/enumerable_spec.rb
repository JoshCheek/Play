require 'spec_helper'
require 'project_euler/core_extensions/enumerable'

describe Enumerable do
  describe 'sum' do
    specify { [].sum.should be_nil }
    specify { [1].sum.should == 1 }
    specify { [1,2].sum.should == 3 }
    specify { [1,2,3,4,5].sum.should == 15 }
    specify { %w[a b c].sum.should == 'abc' }
    specify { (5..7).sum.should == 5+6+7 }
  end
end
