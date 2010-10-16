#!/usr/bin/env ruby

require 'test/unit'
require 'rubygems'
require 'sqlite3'
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
  
  def self.to_method_name(str)
    str.gsub(/\s+/,'_').gsub(/\W+/,'')
  end
  
  def self.context(context)
    @context = to_method_name(context)
  end
  
  def self.verify( to_verify , &verification )
    prefix = "test_"
    prefix << @context << '_' if @context && !context.empty?
    define_method prefix << to_method_name(to_verify) , &verification
  end
  
  context 'querying'
  verify 'if setting DNE, should create it' do
    assert_equal 0 , Setting.count
    
  end
end
