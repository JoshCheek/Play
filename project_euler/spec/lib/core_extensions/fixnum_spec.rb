require 'spec_helper'
require 'project_euler/core_extensions/fixnum'

describe Fixnum do  
  describe '#digits' do
    sample = [1,2,3,4,5,6,7,8,9,0] * 3
    sample.each_index do |size|
      crnt = sample.take(size.next)
      next unless crnt.join.to_i.is_a? Fixnum
      specify { crnt.join.to_i.digits.should == crnt }
    end
  end
end
