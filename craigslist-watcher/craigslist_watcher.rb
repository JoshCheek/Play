#! /usr/bin/env ruby

# This script is not intended to be run directly, but rather as a cron job
# see the cron.rb file

# this script will watch Craigslist for free stuff in wichita
# inparticular, I will use it to find a free computer to put linux on so I can play with chef

require 'open-uri'
require 'yaml'
require 'rubygems'
require 'nokogiri'
require 'ruby-growl' # you'll have to use some other form of notification if not on a Mac (if it doesn't work, check your growl network settings)

raise 'submit a keyword to watch for' unless ARGV.size == 1
Link      =  Struct.new :url , :text
keyword   =  ARGV.first
matcher   =  Regexp.new Regexp.escape(keyword) , Regexp::IGNORECASE
filename  =  File.dirname(__FILE__)+"/#{keyword}.yml"
seen      =  if File.exist?(filename) then YAML.load(open filename) else Array.new end
growler   =  Growl.new 'localhost', 'Craigslist Watcher', [ keyword ] 


Nokogiri::HTML(open 'http://wichita.craigslist.org/zip/').css('.row').each do |row| 
  link = Link.new row.at_css('a')['href'] , row.at_css('a').text
  next if seen.include? link
  next if link.text !~ matcher
  seen << link
  growler.notify keyword , link.url , link.text
end


File.open filename , 'w' do |file|
  file.print( YAML.dump seen )
end
