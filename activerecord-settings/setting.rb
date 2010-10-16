#!/usr/bin/env ruby

require 'test/unit'
require 'sqlite3'
require 'rubygems'
require 'active_record'

# set up the database
ActiveRecord::Base.establish_connection :adapter  => 'sqlite3' , :database => ":memory:" 
class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.text :name
      t.text :value
    end
  end
end
CreateSettings.migrate :up


# run the unit tests
class TestSettingModel < Test::Unit::TestCase
  
  def self.verify( to_verify , &verification )
    define_method "test_" << to_verify.gsub(/\s+/,'_') , &verification
  end
  
end



