# this file creates the cron job that runs the program every minute to look for new posts
# Learn more: http://github.com/javan/whenever

# TO USE:
#
# $ pwd
# /Users/joshcheek/code/blackboardbot
#
# $ rake cron:on
#
# or
#
# $ rake cron:on minutes=5
#
# or 
#
# $ rake cron:off

@minutes = @minutes.to_i

unless @minutes.zero?
  path_to_rake  =  `which rake`.to_s.strip
  root_path     =  File.expand_path '..' , __FILE__
  
  raise "Rake does not appear to be installed ('$which rake' returns nothing)" if path_to_rake.empty?
  every @minutes.minutes do
    command "cd #{root_path} && #{path_to_rake} run"
  end
end