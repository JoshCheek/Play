require 'spec_helper'
require 'project_euler/core_extensions/integer'


describe Integer do
  describe '#divide?' do
    specify { 5.divide?(0).should         be }
    specify { 5.divide?(1).should_not     be }
    specify { 5.divide?(5).should         be }
    specify { 5.divide?(10).should        be }
    specify { 5.divide?(11).should_not    be }
    specify { 5.divide?(12).should_not    be }
    specify { 5.divide?(13).should_not    be }
    specify { 5.divide?(14).should_not    be }
    specify { 5.divide?(15).should        be }
    specify { 10.divide?(100).should      be }
    specify { 10.divide?(101).should_not  be }
  end
  
  describe '#prime_factors' do
    specify { 2.prime_factors.should == [2] }
    specify { 3.prime_factors.should == [3] }
    specify { 8.prime_factors.should == [2] }
    specify { 84.prime_factors.should == [2, 3, 7] }
  end
  
  describe '#prime_factorization' do
    specify { 2.prime_factorization.should  == [2]        }
    specify { 8.prime_factorization.should  == [2,2,2]    }
    specify { 9.prime_factorization.should  == [3,3]      }
    specify { 15.prime_factorization.should == [3,5]      }
    specify { 84.prime_factorization.should == [2,2,3,7]  }
  end
  
  describe '#digits' do
    sample = [1,2,3,4,5,6,7,8,9,0] * 3
    sample.each_index do |size|
      specify do
        crnt = sample.take(size.next)
        crnt.join.to_i.digits.should == crnt
      end
    end
  end
  
  describe '#prime?' do
    specify { 7.should be_prime }
    specify { 8.should_not be_prime }
  end
end