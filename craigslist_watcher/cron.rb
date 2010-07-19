#! /usr/bin/env whenever --update-crontab craigslist --load-file 

# you'll need the whenever gem


# pass as arguments, whatever keywords you wish to search for
# ie, to search for a free computer and lawnmower:      $ ./cron.rb computer lawnmower
# or to turn all of them off:                           $ ./cron.rb
#
# Note that it is not cumulative -- ie each time you run this file, it overwrites the previous values
# Note that you can check that it is doing what you want with $ crontab -l

every 5.minutes do
  ARGV.each do |keyword|
    command File.expand_path( '..' , __FILE__ ) + "/craigslist_watcher.rb #{keyword}"
  end
end
