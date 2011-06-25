require 'spec_helper'
require 'project_euler/core_extensions/array'

describe 'Array#palindrome?' do
  # should
  specify { [               ].should be_palindrome }
  specify { [ 1             ].should be_palindrome }
  specify { [ "a"           ].should be_palindrome }
  specify { [ "a1"          ].should be_palindrome }
  specify { [ 1,1           ].should be_palindrome }
  specify { [ 1,2,1         ].should be_palindrome }
  specify { [ 1,2,2,1       ].should be_palindrome }
  specify { [ 1,"a","a",1   ].should be_palindrome }
  specify { [ 1,1,2,3,2,1,1 ].should be_palindrome }
  specify { [ 9,1,9         ].should be_palindrome }
  
  # should not
  specify { [ 1,2           ].should_not be_palindrome }
  specify { [ 1,2,3         ].should_not be_palindrome }
  specify { [ 1,2,2,1,0     ].should_not be_palindrome }
  specify { [ 1,1,2         ].should_not be_palindrome }
  specify { [ 1,'a'         ].should_not be_palindrome }
end