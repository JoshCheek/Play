#!/usr/bin/env ruby -s

%w( $arg1 $arg2 $arg3 $arg4 ).each do |var| 
  puts "#{var} = #{eval(var).inspect}"
end
