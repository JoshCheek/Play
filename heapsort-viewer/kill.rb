#!/usr/bin/env ruby

to_kill = %x[ps -u josh].split("\n").map { |line| line.split }.select { |line| line[4] == 'ruby' && line[5] == './to_image.rb' }

if to_kill.size != 1
  puts "Expected one thread to kill, but got these:"
  require 'pp'
  pp to_kill
  exit 1
else
  system "kill -9 #{to_kill.first[1]}"
end
