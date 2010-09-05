#!/usr/bin/env ruby

# returns whether to_images is still running
def running?
  %x[ps -u #{USERNAME}].split("\n").map { |line| line.split }.select { |line| line[1] == PID }.size == 1
end

# finds a list of kill candidates: processes that are generating an image
def kill_candidates 
  %x[ps -u #{USERNAME}].
    split("\n").
    map     { |line| line.split                                       }.
    select  { |line| line[4] == 'ruby' && line[5] == './to_image.rb'  }.
    map     { |line| line[1]                                          }.
    flatten
end



# get the name of this user
USERNAME = %x[whoami].chomp

# candidate processes (running the to_images.rb script)
# monitoring the candidate pid will allow us to know when this script is no longer needed, and it can finish on its own without us killing it
candidates = %x[ps -u #{USERNAME}].split("\n").map { |line| line.split }.select { |line| line[4] == 'ruby' && line[5] == './to_images.rb' }

# we expect exactly 1 process to be running to_images.rb
if candidates.size != 1
  puts "Expected one thread to kill, but got these:"
  require 'pp'
  pp candidates
  exit 1
else
  PID = candidates.first[1]   # extract the PID
end

# notify for verification
puts "WATCHING #{PID}" 
puts '--------------'

# every two seconds, check our kill candidates
# if one of them has been around since the last time we checked, assume it froze and kill it
while running?
  candidates = kill_candidates
  sleep 2
  new_candidates = kill_candidates
  ( candidates & new_candidates ).each do |to_kill|
    puts "KILLING #{to_kill}"
    system "kill -9 #{to_kill}"
  end
  candidates = new_candidates
end

